package com.adobe.ac.samples.lcds.dao.jpa;

import org.springframework.stereotype.Repository;

import com.adobe.ac.lcds.dao.jpa.GenericDaoJpa;
import com.adobe.ac.samples.lcds.dao.TodoItemDao;
import com.adobe.ac.samples.lcds.model.TodoItem;

@Repository("todoItemDao")
public class TodoItemJpaDao
      extends GenericDaoJpa< TodoItem, Integer > implements TodoItemDao
{
   public TodoItemJpaDao()
   {
      super( TodoItem.class );
   }
}