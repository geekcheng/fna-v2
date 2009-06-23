package com.adobe.ac.samples.lcds.service;

import com.adobe.ac.lcds.assemblers.SimpleAssembler;
import com.adobe.ac.lcds.dao.jpa.GenericDaoJpa;
import com.adobe.ac.samples.lcds.model.TodoItem;

public class TodoAssembler
      extends SimpleAssembler< TodoItem >
{
   private static final String ID = "id";

   public TodoAssembler()
   {
      super( new GenericDaoJpa< TodoItem, Long >( TodoItem.class ) );
   }

   @Override
   protected String getIdentityName()
   {
      return ID;
   }

   @Override
   protected Long getIdentityValue(
         TodoItem item )
   {
      return item.getId();
   }
}