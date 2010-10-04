package com.adobe.txi.todo.service;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;

import com.adobe.txi.todo.dto.TodoItemDto;

@ContextConfiguration(locations = { "classpath:/applicationContext-persistence.xml",
        "classpath:/applicationContext-remoting.xml" })
public class TodoServiceTest extends AbstractTransactionalJUnit4SpringContextTests
{
    @Autowired
    @Qualifier("todoService")
    private ICrudService<TodoItemDto, Integer> todoService;

    @Test
    public void testCreateGetUpdateRemoveGetAll()
    {
        int todoNb = todoService.getAll().size();

        TodoItemDto dto = new TodoItemDto();

        dto.setTitle("testing creation");
        dto = todoService.save(dto);
        Integer id = dto.getId();
        Assert.assertNotNull(id);

        Assert.assertEquals(todoNb + 1, todoService.getAll().size());

        todoService.get(id);
        Assert.assertEquals(dto.getTitle(), "testing creation");

        dto.setTitle("testing update");
        dto = todoService.save(dto);
        Assert.assertEquals(dto.getTitle(), "testing update");
        Assert.assertEquals(dto.getId(), id);

        todoService.remove(id);

        Assert.assertEquals(todoNb, todoService.getAll().size());
    }

}
