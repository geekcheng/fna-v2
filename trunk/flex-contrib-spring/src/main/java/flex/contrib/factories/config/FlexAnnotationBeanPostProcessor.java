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

package flex.contrib.factories.config;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.config.BeanPostProcessor;
import org.springframework.core.annotation.AnnotationUtils;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.ContextLoaderServlet;

import flex.contrib.services.SpringAutowiringBootstrapService;
import flex.contrib.stereotypes.RemotingDestination;
import flex.contrib.utils.FlexUtils;
import flex.messaging.MessageBroker;
import flex.messaging.MessageBrokerServlet;

/**
 * {@link BeanPostProcessor} that creates Flex remoting destinations for beans
 * that are annotated with the {@link RemotingDestination} annotation. 
 * 
 * <p>This bean processor can only be used when the application context is 
 * loaded using the {@link ContextLoaderServlet}. The {@link MessageBrokerServlet} 
 * must have a lower <code>load-on-startup</code> value in <code>web.xml</code> 
 * than the ContextLoaderServlet as this bean processor needs the 
 * {@link MessageBroker} created by the MessageBrokerServlet.
 * 
 * <p>For usage, simply define the following bean in your application context:
 * 
 * <pre class="code">
 * &lt;bean id="flexAnnotationBeanPostProcessor" class="flex.contrib.factories.config.FlexAnnotationBeanPostProcessor"/&gt;
 * </pre>
 * 
 * Note that application level default channels, as define below in the Flex 
 * services-config, are necessary when a dynamic destination is being used by a 
 * service component and no ChannelSet has been defined for the service component. 
 * In that case, application level default channels will be used to contact the 
 * destination. 
 * 
 * <pre class="code">
 * &lt;services&gt;
 * 
 *     ... service definitions ...
 *     
 *     &lt;default-channels&gt;
 *         &lt;channel ref="my-amf"/&gt;
 *     &lt;/default-channels&gt;     
 *     
 * &lt;/services&gt;
 * </pre>
 * 
 * <p>In case the application context is loaded using the 
 * {@link ContextLoaderListener}, then the {@link SpringAutowiringBootstrapService} 
 * can be used to create the remoting destination.
 * 
 * @author Marcel Overdijk, marceloverdijk@gmail.com
 * @see SpringAutowiringBootstrapService
 */
public class FlexAnnotationBeanPostProcessor implements BeanPostProcessor {
	
	public Object postProcessBeforeInitialization(Object bean, String beanName) throws BeansException {
		return bean;
	}
	
	public Object postProcessAfterInitialization(Object bean, String beanName) throws BeansException {
		if (AnnotationUtils.isAnnotationDeclaredLocally(RemotingDestination.class, bean.getClass())) {
			FlexUtils.createRemotingDestination(bean, beanName);
		}
		return bean;
	}

}
