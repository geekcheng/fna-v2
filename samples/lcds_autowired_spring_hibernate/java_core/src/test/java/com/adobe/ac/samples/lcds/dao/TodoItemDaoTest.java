package com.adobe.ac.samples.lcds.dao;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.Assert;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.TestExecutionListeners;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;

import com.carbonfive.testutils.spring.dbunit.DataSet;
import com.carbonfive.testutils.spring.dbunit.DataSetTestExecutionListener;
import com.adobe.ac.samples.lcds.model.TodoItem;

@ContextConfiguration(locations =
{ "classpath:/applicationContext-core.xml" })
@TestExecutionListeners(
{ DataSetTestExecutionListener.class })
public class TodoItemDaoTest
      extends AbstractTransactionalJUnit4SpringContextTests
{

   protected final Log log = LogFactory.getLog( TodoItemDaoTest.class );

   @Autowired
   private TodoItemDao todoItemDao;

   @Test
   @DataSet(value = "/test-data.xml", teardownOperation = "DELETE")
   public void listAllTodoItems()
   {
      List< TodoItem > todoItems = todoItemDao.getAll();
      log.debug( todoItems );
      Assert.assertEquals(
            5, todoItems.size() );
   }

   @Test
   public void testInsert()
   {
      TodoItem todoItem = new TodoItem();
      todoItem.setTitle( "get up get up and do something" );
      todoItemDao.save( todoItem );

      Long id = todoItem.getId();
      log.debug( "returned todoItem ID: "
            + id );
      Assert.assertEquals(
            1, countRowsInTable( "todoitem" ) );
   }
}