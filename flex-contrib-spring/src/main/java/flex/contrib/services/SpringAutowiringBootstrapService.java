/*
 * Copyright 2002-2007 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package flex.contrib.services;

import javax.servlet.ServletContext;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.BeanIsAbstractException;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.ContextLoaderServlet;
import org.springframework.web.context.support.WebApplicationContextUtils;

import flex.contrib.factories.config.FlexAnnotationBeanPostProcessor;
import flex.contrib.stereotypes.RemotingDestination;
import flex.contrib.utils.FlexUtils;
import flex.messaging.MessageBroker;
import flex.messaging.config.ConfigMap;
import flex.messaging.config.ConfigurationException;
import flex.messaging.services.AbstractBootstrapService;

/**
 * {@link AbstractBootstrapService} implementation which scans all registered
 * bean definitions within the Spring {@link ApplicationContext} for beans
 * annotated with the {@link RemotingDestination} annotation. For these beans
 * a Flex remoting destination is created.
 *
 * <p>This bootstrap service is typically used when the application context is
 * loaded using the {@link ContextLoaderListener}.
 *
 * <p>For usage, simply define the following service in your services-config:
 *
 * <pre class="code">
 * &lt;services&gt;
 *
 *     ... other service definitions ...
 *
 *     &lt;service id="spring-autowiring-bootstrap-service" class="flex.contrib.services.SpringAutowiringBootstrapService"/&gt;
 *
 *     &lt;default-channels&gt;
 *         &lt;channel ref="my-amf"/&gt;
 *     &lt;/default-channels&gt;
 *
 * &lt;/services&gt;
 * </pre>
 *
 * Note that application level default channels, as define above, are necessary
 * when a dynamic destination is being used by a service component and no ChannelSet
 * has been defined for the service component. In that case, application level default
 * channels will be used to contact the destination.
 *
 * <p>In case the application context is loaded using the {@link ContextLoaderServlet}
 * then the {@link FlexAnnotationBeanPostProcessor} can also be used as alternative.
 *
 * @author Marcel Overdijk, marceloverdijk@gmail.com
 * @see FlexAnnotationBeanPostProcessor
 */
public class SpringAutowiringBootstrapService extends AbstractBootstrapService {

    private static Log log = LogFactory.getLog(SpringAutowiringBootstrapService.class);

    @Override
    public void initialize(String id, ConfigMap properties) {

        MessageBroker mb = getMessageBroker();

        // get the application context
        ServletContext servletContext = mb.getInitServletContext();
        ApplicationContext ctx = WebApplicationContextUtils.getRequiredWebApplicationContext(servletContext);

        // loop over all registered bean definitions
        String[] beanNames = ctx.getBeanDefinitionNames();
        for (int i = 0; i < beanNames.length; i++) {
            String beanName = beanNames[i];
            try {
                Object bean = ctx.getBean(beanName);
                // if the bean is a remoting destination bean, create the remoting destination
                if (FlexUtils.hasRemotingDestinationAnnotation(bean)) {
                    FlexUtils.createRemotingDestination(bean, beanName, mb);
                }
            }
            catch (BeanIsAbstractException e) {
                // do nothing... abstract beans aren't going to be remote destination beans
            }
            catch (ConfigurationException e) {
                log.error("Unable to configure remoting destination for Spring service named '" + beanName + "'.", e);
            }
            catch (RuntimeException e) {
                log.error("Unable to create remoting destination for Spring service named '" + beanName + "'.", e);
            }
        }
    }

    @Override
    public void start() {}

    @Override
    public void stop() {}

}
