package com.adobe.ac.samples.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.adobe.ac.samples.dao.TodoItemDaoJpa;
import com.adobe.ac.samples.model.TodoItem;
import com.adobe.ac.samples.service.TodoService;

@Service("todoService")
@RemotingDestination(channels = { "channel-amf" })
@Transactional
public class TodoServiceImpl extends GenericManagerImpl<TodoItem, Integer>
    implements TodoService {

    @Autowired
    public TodoServiceImpl(TodoItemDaoJpa todoItemDao) {
        super(todoItemDao);
    }

}
