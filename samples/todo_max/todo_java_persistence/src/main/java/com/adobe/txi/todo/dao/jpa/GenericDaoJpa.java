package com.adobe.txi.todo.dao.jpa;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.EntityNotFoundException;
import javax.persistence.PersistenceContext;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.Session;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.MatchMode;

/**
 * This class serves as the Base class for all other DAOs - namely to hold
 * common CRUD methods that they might all use. You should only need to extend
 * this class when your require custom CRUD logic.
 * 
 * 
 * @param <T>
 *            a type variable
 * @param <PK>
 *            the primary key for that type
 */
public class GenericDaoJpa<T, PK extends Serializable>
{
    /**
     * Log variable for all child classes. Uses LogFactory.getLog(getClass())
     * from Commons Logging
     */
    protected final transient Log log = LogFactory.getLog(getClass());

    /**
     * Entity manager, injected by Spring using @PersistenceContext annotation
     * on setEntityManager()
     */
    @PersistenceContext
    protected transient EntityManager entityManager;

    private final transient Class<T> persistentClass;

    /**
     * Constructor that takes in a class to see which type of entity to persist
     * 
     * @param persistentClass
     *            the class type you'd like to persist
     */
    public GenericDaoJpa(final Class<T> persistentClass)
    {
        this.persistentClass = persistentClass;
    }

    /**
     * {@inheritDoc}
     */
    @SuppressWarnings("unchecked")
    public List<T> getAll()
    {
        return this.entityManager.createQuery("from " + this.persistentClass.getName()).getResultList();
    }

    /**
     * {@inheritDoc}
     */
    public T get(final PK id)
    {
        final T entity = this.entityManager.find(this.persistentClass, id);

        if (entity == null)
        {
            final String msg = "Could not find a '" + this.persistentClass + "' object with id '" + id + "'";
            log.warn(msg);
            throw new EntityNotFoundException(msg);
        }

        return entity;
    }

    /**
     * {@inheritDoc}
     */
    public boolean exists(final PK id)
    {
        final T entity = this.entityManager.find(this.persistentClass, id);
        return entity != null;
    }

    /**
     * {@inheritDoc}
     */
    public T save(final T object)
    {
        return this.entityManager.merge(object);
    }

    /**
     * {@inheritDoc}
     */
    public void remove(final PK id)
    {
        this.entityManager.remove(this.get(id));
    }

    /**
     * Default method used to get a list of data model entities based on a
     * filled instance of that entity
     * 
     * @param exampleInstance
     *            instance of type T used to get values for the search criteria
     * @param excludeProperty
     *            list of String arguments
     * @return List of T entities
     */
    public List<T> findByExample(final T exampleInstance, final String... excludeProperty)
    {
        return findByExample(exampleInstance, MatchMode.START, excludeProperty);
    }

    /**
     * Default method used to get a list of data model entities based on a
     * filled instance of that entity
     * 
     * @param exampleInstance
     *            instance of type T used to get values for the search criteria
     * @param fetchAssociations
     *            an array with the associations which will get fetched eagerly
     * @param excludeProperty
     *            list of String arguments
     * @return List of T entities
     */
    public List<T> findByExample(final T exampleInstance, final String[] fetchAssociations,
            final String... excludeProperty)
    {
        return findByExample(exampleInstance, MatchMode.START, fetchAssociations, excludeProperty);
    }

    /**
     * Default method used to get a list of data model entities based on a
     * filled instance of that entity
     * 
     * @param exampleInstance
     *            instance of type T used to get values for the search criteria
     * @param fetchAssociations
     *            an array with the associations which will get fetched eagerly
     * @param associationCriteria
     *            a map containing criteria for associated objects
     * @param excludeProperty
     *            list of String arguments
     * @return List of T entities
     */
    public List<T> findByExample(final T exampleInstance, final String[] fetchAssociations,
            final Map<String, Object> associationCriteria, final String... excludeProperty)
    {
        return findByExample(exampleInstance, MatchMode.START, fetchAssociations, associationCriteria, excludeProperty);
    }

    /**
     * Extended method used to get a list of data model entities based on a
     * filled instance of that entity. Allows the caller to provide the match
     * mode as a parameter
     * 
     * @param exampleInstance
     *            instance of type T used to get values for the search criteria
     * @param mode
     *            MatchMode property designating a matching mode
     * @param excludeProperty
     *            list of String arguments
     * @return List of T entities
     */
    @SuppressWarnings("unchecked")
    public List<T> findByExample(final T exampleInstance, final MatchMode mode, final String... excludeProperty)
    {
        Session session = (Session) entityManager.getDelegate();
        Criteria crit = session.createCriteria(this.persistentClass);

        final org.hibernate.criterion.Example example = org.hibernate.criterion.Example.create(exampleInstance);
        for (String exclude : excludeProperty)
        {
            example.excludeProperty(exclude);
        }
        example.ignoreCase();
        example.enableLike(mode);

        crit.add(example);
        final List<T> result = crit.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY).list();
        return result;
    }

    /**
     * Extended method used to get a list of data model entities based on a
     * filled instance of that entity. Allows the caller to provide the match
     * mode as a parameter
     * 
     * @param exampleInstance
     *            instance of type T used to get values for the search criteria
     * @param mode
     *            MatchMode property designating a matching mode
     * @param fetchAssociations
     *            array containing the associations which should be eagerly
     *            fetched
     * @param excludeProperty
     *            list of String arguments
     * @return List of T entities
     */
    @SuppressWarnings("unchecked")
    public List<T> findByExample(final T exampleInstance, final MatchMode mode, final String[] fetchAssociations,
            final String... excludeProperty)
    {
        Session session = (Session) entityManager.getDelegate();
        Criteria crit = session.createCriteria(this.persistentClass);

        final org.hibernate.criterion.Example example = org.hibernate.criterion.Example.create(exampleInstance);
        for (String exclude : excludeProperty)
        {
            example.excludeProperty(exclude);
        }
        example.ignoreCase();
        example.enableLike(mode);

        crit.add(example);

        if (fetchAssociations != null && fetchAssociations.length > 0)
        {
            for (String association : fetchAssociations)
            {
                crit.setFetchMode(association, FetchMode.JOIN);
            }
        }

        final List<T> result = crit.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY).list();
        return result;
    }

    /**
     * Extended method used to get a list of data model entities based on a
     * filled instance of that entity. Allows the caller to provide the match
     * mode as a parameter
     * 
     * @param exampleInstance
     *            instance of type T used to get values for the search criteria
     * @param mode
     *            MatchMode property designating a matching mode
     * @param fetchAssociations
     *            array containing the associations which should be eagerly
     *            fetched
     * @param associationCriteria
     *            a map containing criteria for associated objects
     * @param excludeProperty
     *            list of String arguments
     * @return List of T entities
     */
    @SuppressWarnings("unchecked")
    public List<T> findByExample(final T exampleInstance, final MatchMode mode, final String[] fetchAssociations,
            final Map<String, Object> associationCriteria, final String... excludeProperty)
    {
        Session session = (Session) entityManager.getDelegate();
        Criteria crit = session.createCriteria(this.persistentClass);

        final org.hibernate.criterion.Example example = org.hibernate.criterion.Example.create(exampleInstance);
        for (String exclude : excludeProperty)
        {
            example.excludeProperty(exclude);
        }
        example.ignoreCase();
        example.enableLike(mode);

        crit.add(example);

        if (fetchAssociations != null && fetchAssociations.length > 0)
        {
            for (String association : fetchAssociations)
            {
                crit.setFetchMode(association, FetchMode.JOIN);
            }
        }

        if (associationCriteria != null && !associationCriteria.isEmpty())
        {
            for (String criterionName : associationCriteria.keySet())
            {
                final Criteria criterion = crit.createCriteria(criterionName);
                final Example criteriaExample = Example.create(associationCriteria.get(criterionName));
                criteriaExample.ignoreCase().enableLike(mode);
                criterion.add(criteriaExample);
            }
        }

        final List<T> result = crit.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY).list();
        return result;
    }

}