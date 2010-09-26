/**
 * 
 */
package com.adobe.txi.todo.exception;

/**
 * Enum containing the codes of all todo-specific exceptions. The codes are
 * used to identify the exceptions thrown by the server-side to any client.
 * 
 */
public enum ExceptionCode
{

    /**
     * Exception reflecting an unexpected, unknown? unstable application state
     */
    UNKNOWN,

    /**
     * Code for the Exception reflecting a known (generically coded), but
     * unstable application state
     * 
     */
    GENERIC,

    /**
     * Signals that the user session has timed out.
     */
    SESSION_TERMINATED,

}