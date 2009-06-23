package flex.contrib.messaging.services.remoting.adapters;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.security.AccessDeniedException;

import flex.messaging.FactoryInstance;
import flex.messaging.FlexContext;
import flex.messaging.MessageException;
import flex.messaging.config.ConfigMap;
import flex.messaging.config.SecurityConstraint;
import flex.messaging.log.Log;
import flex.messaging.messages.Message;
import flex.messaging.messages.RemotingMessage;
import flex.messaging.security.SecurityException;
import flex.messaging.services.remoting.RemotingDestination;
import flex.messaging.services.remoting.adapters.JavaAdapter;
import flex.messaging.services.remoting.adapters.RemotingMethod;
import flex.messaging.util.ExceptionUtil;
import flex.messaging.util.MethodMatcher;
import flex.messaging.util.StringUtils;
import flex.messaging.util.MethodMatcher.Match;

@SuppressWarnings("unchecked")
public class SpringSecurityJavaAdapter extends JavaAdapter {

    /** copied from private: flex.messaging.security.LoginManager.ACCESS_DENIED */
    private static final int ACCESS_DENIED = 10055;

    /** copied from private: flex.messaging.security.LoginManager.LOGIN_REQ_FOR_AUTH */
    private static final int LOGIN_REQ_FOR_AUTH = 10056;

    private Map<String,RemotingMethod> includeMethods;
    private Map<String,RemotingMethod>  excludeMethods;

    /**
     * {@inheritDoc}.
     */
    @Override
    public void initialize(String id, ConfigMap properties) {
        super.initialize(id, properties);
        this.includeMethods = new HashMap<String,RemotingMethod>();
        for (Iterator<RemotingMethod> i = getIncludeMethodIterator(); i.hasNext(); ) {
            RemotingMethod ri = i.next();
            this.includeMethods.put(ri.getName(), ri);
        }
        this.excludeMethods = new HashMap<String,RemotingMethod>();
        for (Iterator<RemotingMethod> i = getExcludeMethodIterator(); i.hasNext(); ) {
            RemotingMethod ri = i.next();
            this.excludeMethods.put(ri.getName(), ri);
        }
    }

    /**
     * {@inheritDoc}.
     * Invoke method converting any AccessDeniedException exceptions from Spring Security
     * into related Flex Security exceptions.
     */
    @Override
    public Object invoke(Message message)
    {
        RemotingDestination remotingDestination = (RemotingDestination)getDestination();
        RemotingMessage remotingMessage = (RemotingMessage)message;
        FactoryInstance factoryInstance = remotingDestination.getFactoryInstance();

        // We don't allow the client to specify the source for
        // Java based services.
        String className = factoryInstance.getSource();
        remotingMessage.setSource(className);

        String methodName = remotingMessage.getOperation();
        List parameters = remotingMessage.getParameters();
        Object result = null;

        try
        {
            // Test that the target method may be invoked based upon include/exclude method settings.
            if (includeMethods != null)
            {
                RemotingMethod method = (RemotingMethod)includeMethods.get(methodName);
                if (method == null)
                    MethodMatcher.methodNotFound(methodName, null, new Match(null));

                // Check method-level security constraint, if defined.
                SecurityConstraint constraint = method.getSecurityConstraint();
                if (constraint != null)
                    getDestination().getService().getMessageBroker().getLoginManager().checkConstraint(constraint);
            }
            else if ((excludeMethods != null) && excludeMethods.containsKey(methodName))
                MethodMatcher.methodNotFound(methodName, null, new Match(null));

            // Lookup and invoke.
            Object instance = createInstance(factoryInstance.getInstanceClass());
            if (instance == null)
            {
                MessageException me = new MessageException("Null instance returned from: " + factoryInstance);
                me.setCode("Server.Processing");
                throw me;
            }
            Class c = instance.getClass();

            MethodMatcher methodMatcher = remotingDestination.getMethodMatcher();
            Method method = methodMatcher.getMethod(c, methodName, parameters);
            result = method.invoke(instance, parameters.toArray());

            saveInstance(instance);
        }
        catch (InvocationTargetException ex)
        {
            /*
             * If the invocation exception wraps a message exception, unwrap it and
             * rethrow the nested message exception. Otherwise, build and throw a new
             * message exception.
             */
            Throwable cause = ex.getCause();
            if ((cause != null) && (cause instanceof MessageException))
            {
                throw (MessageException) cause;
            }
            else if (cause != null && cause instanceof AccessDeniedException) {
                AccessDeniedException ade = (AccessDeniedException) cause;
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
            else if (cause != null)
            {
                // Log a warning for this client's selector and continue
                if (Log.isError())
                {
                    Log.getLogger(getLogCategory()).error("Error processing remote invocation: " +
                         cause.toString() + StringUtils.NEWLINE +
                         "  incomingMessage: " + message + StringUtils.NEWLINE +
                         ExceptionUtil.toString(cause));
                }
                MessageException me = new MessageException(cause.getClass().getName() + " : " + cause.getMessage());
                me.setCode("Server.Processing");
                me.setRootCause(cause);
                throw me;
            }
            else
            {
                MessageException me = new MessageException(ex.getMessage());
                me.setCode("Server.Processing");
                throw me;
            }
        }
        catch (IllegalAccessException ex)
        {
            MessageException me = new MessageException(ex.getMessage());
            me.setCode("Server.Processing");
            throw me;
        }

        return result;
    }

}