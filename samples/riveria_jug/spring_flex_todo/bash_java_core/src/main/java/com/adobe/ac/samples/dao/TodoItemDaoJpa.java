package com.adobe.ac.samples.dao;

import org.springframework.stereotype.Repository;

import com.adobe.ac.samples.model.TodoItem;

@Repository("todoItemDao")
public class TodoItemDaoJpa extends GenericDaoJpa<TodoItem, Integer> {

    public TodoItemDaoJpa() {
        super(TodoItem.class);
    }

}