package com.adobe.ac.lcds.assemblers;

import java.text.MessageFormat;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import javax.persistence.EntityManagerFactory;
import javax.servlet.ServletContext;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.NoSuchBeanDefinitionException;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.adobe.ac.lcds.dao.GenericDao;

import flex.data.assemblers.AbstractAssembler;
import flex.messaging.services.ServiceException;

public abstract class SimpleAssembler< DataSetType >
      extends AbstractAssembler
{
   private static final String SIMPLE_ASSEMBLER = "SimpleAssembler:";
   private static final Logger LOGGER = Logger.getLogger( SimpleAssembler.class
         .getName() );
   
   
   private GenericDao< DataSetType, Long > dao;

   public SimpleAssembler(
         GenericDao< DataSetType, Long > dao )
   {

       // get the application context
       ServletContext servletContext = flex.messaging.FlexContext.getServletConfig().getServletContext();
       ApplicationContext ctx = WebApplicationContextUtils.getRequiredWebApplicationContext(servletContext);

       EntityManagerFactory inst = (EntityManagerFactory) ctx.getBean("entityManagerFactory");
       // loop over all registered bean definitions
 	   
      this.dao = dao;
      //FIXME
      //dao.setEntityManagerFactory(inst);
   }

   @Override
   public void createItem(
         final Object item )
   {
      LOGGER.info( MessageFormat.format(
            "{0}{1}.createItem()", new Object[]
            { SIMPLE_ASSEMBLER, getClassName() } ) );

      dao.save( getTypedObject( item ) );
   }

   @Override
   public void deleteItem(
         final Object item )
   {
      final Long deletingItemId = getIdentityValue( getTypedObject( item ) );

      LOGGER.info( MessageFormat.format(
            "{0}{1}.deleteItem( {2}: {3} )", new Object[]
            { SIMPLE_ASSEMBLER, getClassName(), getIdentityName(),
                  deletingItemId } ) );

      dao.remove( deletingItemId );
   }

   @Override
   public Collection< DataSetType > fill(
         final List fillParameters )
   {
      LOGGER.info( MessageFormat.format(
            "{0}{1}.fill( {2} )", new Object[]
            { SIMPLE_ASSEMBLER, getClassName(),
                  AssemblerUtils.printParameterList( fillParameters ) } ) );

      return dao.getAll();
   }

   @Override
   public Object getItem(
         final Map map )
   {
      final long identity = ( ( Integer ) map.get( getIdentityName() ) )
            .longValue();

      LOGGER.info( MessageFormat.format(
            "{0}.getItem( {1}: {2} )", new Object[]
            { getClassName(), getIdentityName(), identity } ) );

      return dao.get( identity );
   }

   @SuppressWarnings("unchecked")
   @Override
   public void updateItem(
         final Object newVersion, final Object previousVersion,
         final List changes )
   {
      LOGGER.info( MessageFormat.format(
            "{0}{1}.updateItem( {2}: {3} )", new Object[]
            { SIMPLE_ASSEMBLER, getClassName(), getIdentityName(),
                  getIdentityValue( getTypedObject( previousVersion ) ) } ) );

      AssemblerUtils.printChanges(
            newVersion, previousVersion, changes );

      dao.save( getTypedObject( newVersion ) );
   }

   /**
    * Used to extract the identity value from the hashmap given as getItem
    * parameter.
    * 
    * @return the identity field name (most of cases will be "id")
    */
   protected abstract String getIdentityName();

   /**
    * Extract the identity value from an object
    * 
    * @param item
    * @return the identity value
    */
   protected abstract Long getIdentityValue(
         final DataSetType item );

   private String getClassName()
   {
      return getClass().getName();
   }

   @SuppressWarnings("unchecked")
   private DataSetType getTypedObject(
         final Object item )
   {
      return ( DataSetType ) item;
   }
   
   
   
   public Object lookup() 
   {
       ApplicationContext appContext = WebApplicationContextUtils.getWebApplicationContext(flex.messaging.FlexContext.getServletConfig().getServletContext());
       String beanName = "FIXME";

       try
       {
           return appContext.getBean(beanName);
       }
       catch (NoSuchBeanDefinitionException nexc)
       {
           ServiceException e = new ServiceException();
           String msg = "Spring service named '" + beanName + "' does not exist.";
           e.setMessage(msg);
           e.setRootCause(nexc);
           e.setDetails(msg);
           e.setCode("Server.Processing");
           throw e;
       }
       catch (BeansException bexc)
       {
           ServiceException e = new ServiceException();
           String msg = "Unable to create Spring service named '" + beanName + "' ";
           e.setMessage(msg);
           e.setRootCause(bexc);
           e.setDetails(msg);
           e.setCode("Server.Processing");
           throw e;
       } 
   }
   
}