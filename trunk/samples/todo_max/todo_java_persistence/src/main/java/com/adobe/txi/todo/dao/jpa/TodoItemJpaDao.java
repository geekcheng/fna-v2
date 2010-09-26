package com.adobe.txi.todo.dao.jpa;

import org.springframework.stereotype.Repository;

import com.adobe.txi.todo.dao.ITodoItemDao;
import com.adobe.txi.todo.entity.TodoItem;

@Repository("todoItemDao")
public class TodoItemJpaDao extends GenericDaoJpa<TodoItem, Integer> implements ITodoItemDao
{

    public TodoItemJpaDao()
    {
        super(TodoItem.class);
    }

}