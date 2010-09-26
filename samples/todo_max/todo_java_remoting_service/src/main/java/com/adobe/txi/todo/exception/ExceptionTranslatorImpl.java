/**
 * 
 */
package com.adobe.txi.todo.exception;

import java.util.Date;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.flex.core.ExceptionTranslator;

import flex.messaging.MessageException;

public class ExceptionTranslatorImpl implements ExceptionTranslator
{
    protected final Log logger = LogFactory.getLog(this.getClass());
    private final String GENERIC_ERROR = "The system has encountered an unexpected error.";

    /**
     * {@inheritDoc}
     * 
     * This implementation handles all types of exceptions, so this method will
     * always return <code>true</code>.
     * 
     * @see org.springframework.flex.core.ExceptionTranslator#handles(java.lang.Class
     *      )
     */
    public boolean handles(final Class<?> clazz)
    {
        return Boolean.TRUE;
    }

    /**
     * {@inheritDoc}
     * 
     * Will translate any given <code>Throwable</code> instance to a
     * <code>MessageException</code> and set the appropriate code
     * 
     * @see org.springframework.flex.core.ExceptionTranslator#translate(java.lang
     *      .Throwable)
     */
    public MessageException translate(final Throwable throwable)
    {
        MessageException exception = new MessageException();
        if (throwable != null)
        {
            if (throwable instanceof flex.messaging.client.FlexClientNotSubscribedException
                    || throwable.getCause() instanceof flex.messaging.client.FlexClientNotSubscribedException)
            {
                exception.setRootCause(throwable);
                exception.setMessage("It looks like the flash was unsubscribed to the back end messaging");
                exception.setCode(ExceptionCode.SESSION_TERMINATED.toString());

            }
            else
            {
                return getUnknownErrorMessageException(throwable);
            }
        }
        return getUnknownErrorMessageException(throwable);

    }

    private MessageException getUnknownErrorMessageException(final Throwable throwable)
    {
        MessageException exception = new MessageException();
        long logId = new Date().getTime();
        String code = ExceptionCode.UNKNOWN.toString();
        StringBuffer message = new StringBuffer(GENERIC_ERROR);
        message.append("(" + logId + ")");

        if (null != throwable && null != throwable.getMessage())
        {
            message.append(": ");
            message.append(throwable.getMessage());
        }
        logger.warn("Exception, code = " + code + " message = " + message + " sent to flash");
        exception.setRootCause(throwable);
        exception.setCode(code);
        exception.setMessage(message.toString());
        return exception;
    }
}
