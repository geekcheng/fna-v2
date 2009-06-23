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

package flex.contrib.stereotypes;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

/**
 * Indicates that an annotated class is a Flex "remoting destination".
 * Such classes are automatically registered as remoting destinations
 * within the Flex message broker. No configuration for the destination
 * is needed anymore in the Flex services-config files.
 *
 * <p>The annotated classes are processed by either the
 * {@link FlexAnnotationBeanPostProcessor} which need to be added
 * manually as a bean to the Spring application context, or the
 * {@link SpringAutowiringBootstrapService} which needed to be added
 * manually as a service to the Flex services-config files.
 *
 * @author Marcel Overdijk, marceloverdijk@gmail.com
 * @see FlexAnnotationBeanPostProcessor
 * @see SpringAutowiringBootstrapService
 */
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Component
@Service
public @interface RemotingDestination {

    public static final String SPRING_FACTORY_ID = "spring";
    public static final String REMOTING_SERVICE_ID = "remoting-service";

    /**
    * The message broker may indicate an alternative Flex message broker.
    * If not specified the default message broker will be used.
    * @return the message broker id
    */
    String messageBroker() default "";

    /**
    * The service may indicate an alternative Flex service.
    * If not specified the default "remoting-service" will be used.
    * @return the message broker id
    */
    String service() default REMOTING_SERVICE_ID;

    /**
    * The destination may indicate an alternative Flex remoting destination id.
    * If not specified the bean name is used.
    * @return the destination id
    */
    String destination() default "";

    /**
    * The factory may indicate an alternative Flex factory id.
    * If not specified the Spring factory will be used.
    * @return the factory id
    */
    String factory() default SPRING_FACTORY_ID;

    /**
    * The channels may indicate alternative Flex channels.
    * @return the channels
    */
    String[] channels() default {};

    String[] securityRoles() default {};

}