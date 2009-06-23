package flex.contrib.factories.config;

import org.aopalliance.aop.Advice;
import org.springframework.aop.Pointcut;
import org.springframework.aop.support.AbstractPointcutAdvisor;
import org.springframework.aop.support.annotation.AnnotationMatchingPointcut;

import flex.contrib.stereotypes.RemotingDestination;

/**
 * Spring AOP exception translation aspect for use at Service level.
 * Translates native persistence exceptions into Spring's DataAccessException hierarchy,
 * based on a given SecurityExceptionTranslator.
 *
 * @see flex.contrib.factories.config.SecurityExceptionTranslator
 */
@SuppressWarnings("serial")
public class SecurityExceptionTranslationAdvisor extends AbstractPointcutAdvisor {

    private final SecurityExceptionTranslationInterceptor advice;

    private final AnnotationMatchingPointcut pointcut;


    /**
    * Create a new SecurityExceptionTranslationAdvisor.
    * @param securityExceptionTranslator the SecurityExceptionTranslator to use
    * @param repositoryAnnotationType the annotation type to check for
    */
    public SecurityExceptionTranslationAdvisor() {
        this.advice = new SecurityExceptionTranslationInterceptor();
        this.pointcut = new AnnotationMatchingPointcut(RemotingDestination.class, true);
    }

    public Advice getAdvice() {
        return this.advice;
    }

    public Pointcut getPointcut() {
        return this.pointcut;
    }

}
