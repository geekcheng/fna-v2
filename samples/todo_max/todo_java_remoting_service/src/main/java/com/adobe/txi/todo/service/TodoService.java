package com.adobe.txi.todo.service;

import java.util.ArrayList;
import java.util.List;

import org.dozer.DozerBeanMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.flex.remoting.RemotingInclude;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.adobe.txi.todo.dao.ITodoItemDao;
import com.adobe.txi.todo.dto.TodoItemDto;
import com.adobe.txi.todo.entity.TodoItem;

@Service("todoService")
@RemotingDestination(channels = { "my-prefered-channel" })
public class TodoService implements ICrudService<TodoItemDto, Integer>
{
    @Autowired
    private ITodoItemDao todoItemDao;

    @Autowired
    @Qualifier("todoMapper")
    private DozerBeanMapper todoMapper;

    @RemotingInclude
    @Transactional
    public TodoItemDto get(Integer id)
    {
        TodoItem entity = todoItemDao.get(id);
        return todoMapper.map(entity, TodoItemDto.class);
    }

    @RemotingInclude
    @Transactional
    public List<TodoItemDto> getAll()
    {
        List<TodoItemDto> todolist = new ArrayList<TodoItemDto>();
        List<TodoItem> todos = todoItemDao.getAll();
        for (TodoItem todo : todos)
        {
            todolist.add(todoMapper.map(todo, TodoItemDto.class));
        }
        return todolist;
    }

    @RemotingInclude
    @Transactional
    public void remove(Integer id)
    {
        todoItemDao.remove(new Integer(id));
    }

    @RemotingInclude
    @Transactional
    public TodoItemDto save(TodoItemDto dto)
    {
        TodoItem entity = todoMapper.map(dto, TodoItem.class);
        entity = todoItemDao.save(entity);
        return todoMapper.map(entity, TodoItemDto.class);
    }

}