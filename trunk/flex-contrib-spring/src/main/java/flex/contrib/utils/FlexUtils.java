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

package flex.contrib.utils;

import static flex.contrib.stereotypes.RemotingDestination.SPRING_FACTORY_ID;

import org.springframework.aop.support.AopUtils;
import org.springframework.core.annotation.AnnotationUtils;

import flex.contrib.factories.flex.SpringFactory;
import flex.messaging.MessageBroker;
import flex.messaging.config.SecurityConstraint;
import flex.messaging.log.Log;
import flex.messaging.services.RemotingService;
import flex.messaging.services.remoting.RemotingDestination;

/**
 * General utilities for creating the Flex remoting destinations.
 *
 * @author Marcel Overdijk, marceloverdijk@gmail.com
 */
public class FlexUtils {

    /**
    * Creates a Flex remoting destination within the Flex message broker.
    * The message broker, service, destination, factory, channels are determined
    * by provided annotation elements or using default values.
    *
    * <p>Also automatically adds the {@link SpringFactory} within the
    * message broker if needed.
    *
    * @param bean the bean for which the remoting destination will be created
    * @param beanName the bean name
    */
    public static void createRemotingDestination(Object bean, String beanName) {

        // get the remoting destination annotation from the bean
        flex.contrib.stereotypes.RemotingDestination annotation =
            getRemotingDestinationAnnotation(bean);

        // get the message broker annotation element
        String messageBroker = "".equals(annotation.messageBroker()) ? null : annotation.messageBroker();

        // get the message broker
        MessageBroker mb = MessageBroker.getMessageBroker(messageBroker);

        createRemotingDestination(bean, beanName, mb);
    }

    /**
    * Creates a Flex remoting destination within the Flex message broker.
    * The service, destination, factory, channels are determined
    * by provided annotation elements or using default values.
    *
    * <p>Also automatically adds the {@link SpringFactory} within the
    * message broker if needed.
    *
    * @param bean the bean for which the remoting destination will be created
    * @param beanName the bean name
    * @param mb the message broker
    */
    public static void createRemotingDestination(Object bean, String beanName, MessageBroker mb) {

        // get the remoting destination annotation from the bean
        flex.contrib.stereotypes.RemotingDestination annotation =
            getRemotingDestinationAnnotation(bean);

        // get the annotation elements
        String service = annotation.service();
        String destination = "".equals(annotation.destination()) ? beanName : annotation.destination();
        String factory = annotation.factory();
        String[] channels = annotation.channels() == null ? new String[0] : annotation.channels();

        // add spring factory if not yet registered
        if (SPRING_FACTORY_ID.equals(factory) && !mb.getFactories().containsKey(SPRING_FACTORY_ID)) {
            mb.addFactory(SPRING_FACTORY_ID, new SpringFactory());
        }

        // get the remoting service
        RemotingService rs = (RemotingService) mb.getService(service);

        // create the remoting destination and set factory, source and channels
        RemotingDestination rd = (RemotingDestination) rs.createDestination(destination);
        rd.setFactory(factory);
        rd.setSource(beanName);

        for (String channel : channels) {
            rd.addChannel(channel);
        }

        // [mteodori] add support for security roles
        if (annotation.securityRoles() != null && annotation.securityRoles().length > 0) {
            SecurityConstraint securityConstraint = new SecurityConstraint();
            for (String securityRole : annotation.securityRoles()) {
                securityConstraint.addRole(securityRole);
            }
            rd.setSecurityConstraint(securityConstraint);
        }

        // start the remoting destination
        if (rs.isStarted()) {
            rd.start();
        }

        if (Log.isDebug()) {
            Log.getLogger("Configuration").debug("Flex remoting destination created for bean: " + beanName);
        }
    }

    /**
    * Checks if the bean has a remoting destination annotation declares either locally or using a proxy bean.
    *
    * @param bean the bean for which to check if it has a remoting destination annotation declared
    * @return true if the bean has a remoting destination annotation declared
    */
    public static boolean hasRemotingDestinationAnnotation(Object bean) {
        return (AnnotationUtils.isAnnotationDeclaredLocally(flex.contrib.stereotypes.RemotingDestination.class, bean.getClass()))
            || (AopUtils.isAopProxy(bean) && AnnotationUtils.isAnnotationDeclaredLocally(flex.contrib.stereotypes.RemotingDestination.class, AopUtils.getTargetClass(bean)));
    }

    /**
    * Gets the remoting destination annotation from the bean.
    *
    * @param bean the bean for which to return the remoting destination annotation
    * @return remoting destination annotation of the bean
    */
    public static flex.contrib.stereotypes.RemotingDestination getRemotingDestinationAnnotation(Object bean){
        flex.contrib.stereotypes.RemotingDestination annotation;
        if (!AopUtils.isAopProxy(bean)) {
            annotation = AnnotationUtils.findAnnotation(bean.getClass(), flex.contrib.stereotypes.RemotingDestination.class);
        }
        else {
            annotation = AnnotationUtils.findAnnotation(AopUtils.getTargetClass(bean), flex.contrib.stereotypes.RemotingDestination.class);
        }
        return annotation;
    }
}