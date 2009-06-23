package com.adobe.ac.samples.dao;

import java.io.Serializable;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityNotFoundException;
import javax.persistence.PersistenceContext;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.Session;
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
    protected final Log log = LogFactory.getLog(getClass());

    /**
     * Entity manager, injected by Spring using @PersistenceContext annotation
     * on setEntityManager()
     */
    @PersistenceContext
    protected transient EntityManager entityManager;

    private transient final Class<T> persistentClass;

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
    // public void remove(final T object)
    // {
    // //
    // http://javaswamy.blogspot.com/2008/09/jpa-javalangillegalargumentexception.html
    // if (object.getId() != null) {
    // T entity = this.entityManager.find(this.persistentClass, object
    // .getId());
    // this.entityManager.remove(entity);
    // } else {
    // log.error("the object to remove had no PK");
    // }
    //
    // }
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
    public List<T> findByExample(T exampleInstance, String... excludeProperty)
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
    public List<T> findByExample(T exampleInstance, String[] fetchAssociations, String... excludeProperty)
    {
        return findByExample(exampleInstance, MatchMode.ANYWHERE, fetchAssociations, excludeProperty);
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
    public List<T> findByExample(T exampleInstance, MatchMode mode, String... excludeProperty)
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
        final List<T> result = crit.list();
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
    public List<T> findByExample(T exampleInstance, MatchMode mode, String[] fetchAssociations,
            String... excludeProperty)
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

        final List<T> result = crit.list();
        return result;
    }

    //    
    // /**
    // * @see be.bzbit.framework.domain.repository.GenericRepository#countAll()
    // */
    // @Override
    // public int countAll() {
    // return countByCriteria();
    // }
    //
    // /**
    // * @see
    // be.bzbit.framework.domain.repository.GenericRepository#countByExample(java.lang.Object)
    // */
    // @Override
    // public int countByExample(final T exampleInstance) {
    // Session session = (Session) getEntityManager().getDelegate();
    // Criteria crit = session.createCriteria(getEntityClass());
    // crit.setProjection(Projections.rowCount());
    // crit.add(Example.create(exampleInstance));
    //
    // return (Integer) crit.list().get(0);
    // }
    //
    // /**
    // * @see be.bzbit.framework.domain.repository.GenericRepository#findAll()
    // */
    // @Override
    // public List<T> findAll() {
    // return findByCriteria();
    // }
    //
    // /**
    // * @see
    // be.bzbit.framework.domain.repository.GenericRepository#findByExample(java.lang.Object)
    // */
    // @SuppressWarnings("unchecked")
    // @Override
    // public List<T> findByExample(final T exampleInstance) {
    // Session session = (Session) getEntityManager().getDelegate();
    // Criteria crit = session.createCriteria(getEntityClass());
    // final List<T> result = crit.list();
    // return result;
    // }
    //
    // /**
    // * @see
    // be.bzbit.framework.domain.repository.GenericRepository#findById(java.io.Serializable)
    // */
    // @Override
    // public T findById(final ID id) {
    // final T result = getEntityManager().find(persistentClass, id);
    // return result;
    // }
    //
    // /**
    // * @see
    // be.bzbit.framework.domain.repository.GenericRepository#findByNamedQuery(java.lang.String,
    // java.lang.Object[])
    // */
    // @SuppressWarnings("unchecked")
    // @Override
    // public List<T> findByNamedQuery(final String name, Object... params) {
    // javax.persistence.Query query = getEntityManager().createNamedQuery(
    // name);
    //
    // for (int i = 0; i < params.length; i++) {
    // query.setParameter(i + 1, params[i]);
    // }
    //
    // final List<T> result = (List<T>) query.getResultList();
    // return result;
    // }
    //
    // /**
    // * @see
    // be.bzbit.framework.domain.repository.GenericRepository#findByNamedQueryAndNamedParams(java.lang.String,
    // java.util.Map)
    // */
    // @SuppressWarnings("unchecked")
    // @Override
    // public List<T> findByNamedQueryAndNamedParams(final String name,
    // final Map<String, ? extends Object> params) {
    // javax.persistence.Query query = getEntityManager().createNamedQuery(
    // name);
    //
    // for (final Map.Entry<String, ? extends Object> param : params
    // .entrySet()) {
    // query.setParameter(param.getKey(), param.getValue());
    // }
    //
    // final List<T> result = (List<T>) query.getResultList();
    // return result;
    // }
    //
    // /**
    // * @see
    // be.bzbit.framework.domain.repository.GenericRepository#getEntityClass()
    // */
    // @Override
    // public Class<T> getEntityClass() {
    // return persistentClass;
    // }
    //
    // /**
    // * set the JPA entity manager to use.
    // *
    // * @param entityManager
    // */
    // @Required
    // @PersistenceContext
    // public void setEntityManager(final EntityManager entityManager) {
    // this.entityManager = entityManager;
    // }
    //
    // public EntityManager getEntityManager() {
    // return entityManager;
    // }
    //
    // /**
    // * Use this inside subclasses as a convenience method.
    // */
    // protected List<T> findByCriteria(final Criterion... criterion) {
    // return findByCriteria(-1, -1, criterion);
    // }
    //
    // /**
    // * Use this inside subclasses as a convenience method.
    // */
    // @SuppressWarnings("unchecked")
    // protected List<T> findByCriteria(final int firstResult,
    // final int maxResults, final Criterion... criterion) {
    // Session session = (Session) getEntityManager().getDelegate();
    // Criteria crit = session.createCriteria(getEntityClass());
    //
    // for (final Criterion c : criterion) {
    // crit.add(c);
    // }
    //
    // if (firstResult > 0) {
    // crit.setFirstResult(firstResult);
    // }
    //
    // if (maxResults > 0) {
    // crit.setMaxResults(maxResults);
    // }
    //
    // final List<T> result = crit.list();
    // return result;
    // }
    //
    // protected int countByCriteria(Criterion... criterion) {
    // Session session = (Session) getEntityManager().getDelegate();
    // Criteria crit = session.createCriteria(getEntityClass());
    // crit.setProjection(Projections.rowCount());
    //
    // for (final Criterion c : criterion) {
    // crit.add(c);
    // }
    //
    // return (Integer) crit.list().get(0);
    // }
    //
    //
    // /**
    // * @see
    // be.bzbit.framework.domain.repository.GenericRepository#delete(java.lang.Object)
    // */
    // @Override
    // public void delete(T entity) {
    // getEntityManager().remove(entity);
    // }

}