package com.adobe.ac.samples.dao.jpa;

import org.springframework.stereotype.Repository;

import com.adobe.ac.samples.dao.TodoItemDao;
import com.adobe.ac.samples.model.TodoItem;

@Repository("todoItemDao")
public class TodoItemJpaDao extends GenericDaoJpa<TodoItem, Integer>
    implements TodoItemDao {

    public TodoItemJpaDao() {
        super(TodoItem.class);
    }

}