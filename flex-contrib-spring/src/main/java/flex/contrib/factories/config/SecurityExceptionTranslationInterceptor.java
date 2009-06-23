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

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.springframework.security.AccessDeniedException;

import flex.messaging.FlexContext;
import flex.messaging.security.SecurityException;

/**
 * AOP Alliance MethodInterceptor that provides exception translation from
 * Spring Security to Flex Security.
 */
public class SecurityExceptionTranslationInterceptor
        implements MethodInterceptor {

    /** copied from private: flex.messaging.security.LoginManager.ACCESS_DENIED */
    private static final int ACCESS_DENIED = 10055;

    /** copied from private: flex.messaging.security.LoginManager.LOGIN_REQ_FOR_AUTH */
    private static final int LOGIN_REQ_FOR_AUTH = 10056;

    public Object invoke(MethodInvocation mi) throws Throwable {
        try {
            return mi.proceed();
        } catch (AccessDeniedException ade) {
            SecurityException se = new SecurityException();
            se.setRootCause(ade);

            if (FlexContext.getUserPrincipal() == null) {
                // Login required before authorization can proceed.
                se.setMessage(LOGIN_REQ_FOR_AUTH);
                se.setCode(SecurityException.CLIENT_AUTHENTICATION_CODE);
            } else {
                // Access denied. User not authorized.
                se.setMessage(ACCESS_DENIED);
                se.setCode(SecurityException.CLIENT_AUTHORIZATION_CODE);
            }

            throw se;
        }
    }

}
