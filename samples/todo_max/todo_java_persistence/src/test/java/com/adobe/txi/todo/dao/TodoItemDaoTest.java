package com.adobe.txi.todo.dao;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.Assert;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.TestExecutionListeners;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;

import com.adobe.txi.todo.entity.TodoItem;
import com.carbonfive.testutils.spring.dbunit.DataSet;
import com.carbonfive.testutils.spring.dbunit.DataSetTestExecutionListener;

@ContextConfiguration(locations = { "classpath:/applicationContext-persistence.xml" })
@TestExecutionListeners( { DataSetTestExecutionListener.class })
public class TodoItemDaoTest extends AbstractTransactionalJUnit4SpringContextTests
{

    protected final Log log = LogFactory.getLog(TodoItemDaoTest.class);

    @Autowired
    private ITodoItemDao todoItemDao;

    @Test
    @DataSet(value = "/test-data.xml", teardownOperation = "DELETE")
    public void listAllTodoItems()
    {
        List<TodoItem> todoItems = todoItemDao.getAll();
        log.debug(todoItems);
        Assert.assertEquals(2, todoItems.size());
    }

    @Test
    public void testInsert()
    {
        TodoItem todoItem = new TodoItem();
        todoItem.setTitle("get up get up and do something");
        todoItem = todoItemDao.save(todoItem);

        Integer id = todoItem.getId();
        Assert.assertNotNull(id);
        log.debug("returned todoItem ID: " + id);
        Assert.assertEquals(1, todoItemDao.getAll().size());
    }

}