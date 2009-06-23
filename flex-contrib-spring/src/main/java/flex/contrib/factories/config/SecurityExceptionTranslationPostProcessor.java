/*
 * Copyright 2002-2008 the original author or authors.
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

import org.springframework.aop.framework.Advised;
import org.springframework.aop.framework.ProxyConfig;
import org.springframework.aop.framework.ProxyFactory;
import org.springframework.aop.support.AopUtils;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.BeanClassLoaderAware;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.BeanFactoryAware;
import org.springframework.beans.factory.ListableBeanFactory;
import org.springframework.beans.factory.config.BeanPostProcessor;
import org.springframework.core.Ordered;
import org.springframework.util.ClassUtils;

/**
 * Bean post-processor that automatically applies security exception
 * translation to any bean that carries the
 * {@link flex.contrib.stereotypes.RemotingDestination} annotation,
 * adding a corresponding {@link SecurityExceptionTranslationAdvisor}
 * to the exposed proxy (either an existing AOP proxy or a newly generated
 * proxy that implements all of the target's interfaces).
 */
@SuppressWarnings("serial")
public class SecurityExceptionTranslationPostProcessor extends ProxyConfig
        implements BeanPostProcessor, BeanClassLoaderAware, BeanFactoryAware, Ordered {

    private ClassLoader beanClassLoader = ClassUtils.getDefaultClassLoader();

    private SecurityExceptionTranslationAdvisor securityExceptionTranslationAdvisor;

    public void setBeanClassLoader(ClassLoader classLoader) {
        this.beanClassLoader = classLoader;
    }

    public void setBeanFactory(BeanFactory beanFactory) throws BeansException {
        if (!(beanFactory instanceof ListableBeanFactory)) {
            throw new IllegalArgumentException(
                    "Cannot use PersistenceExceptionTranslator autodetection without ListableBeanFactory");
        }
        this.securityExceptionTranslationAdvisor = new SecurityExceptionTranslationAdvisor();
    }

    public int getOrder() {
        // This should run after all other post-processors, so that it can just add
        // an advisor to existing proxies rather than double-proxy.
        return LOWEST_PRECEDENCE;
    }

    public Object postProcessBeforeInitialization(Object bean, String beanName) throws BeansException {
        return bean;
    }

    public Object postProcessAfterInitialization(Object bean, String beanName) throws BeansException {
        Class<?> targetClass =
                (bean instanceof Advised ? ((Advised) bean).getTargetSource().getTargetClass() : bean.getClass());
        if (targetClass == null) {
            // Can't do much here
            return bean;
        }

        if (AopUtils.canApply(this.securityExceptionTranslationAdvisor, targetClass)) {
            if (bean instanceof Advised) {
                ((Advised) bean).addAdvisor(this.securityExceptionTranslationAdvisor);
                return bean;
            }
            else {
                ProxyFactory proxyFactory = new ProxyFactory(bean);
                // Copy our properties (proxyTargetClass etc) inherited from ProxyConfig.
                proxyFactory.copyFrom(this);
                proxyFactory.addAdvisor(this.securityExceptionTranslationAdvisor);
                return proxyFactory.getProxy(this.beanClassLoader);
            }
        }
        else {
            // This is not a repository.
            return bean;
        }
    }

}