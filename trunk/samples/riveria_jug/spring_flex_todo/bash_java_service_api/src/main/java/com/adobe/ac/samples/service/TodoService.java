package com.adobe.ac.samples.service;

import com.adobe.ac.samples.model.TodoItem;

public interface TodoService extends GenericManager<TodoItem, Integer> {

    void remove(Integer id);

}
