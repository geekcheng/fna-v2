package ${groupId}.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ${groupId}.dao.TodoItemDao;
import ${groupId}.model.TodoItem;
import ${groupId}.service.TodoService;

import flex.contrib.stereotypes.RemotingDestination;

@Service("todoService")
@RemotingDestination
@Transactional
public class TodoServiceImpl extends GenericManagerImpl<TodoItem, Integer>
    implements TodoService {

    private TodoItemDao todoItemDao;

    @Autowired
    public TodoServiceImpl(TodoItemDao todoItemDao) {
        super(todoItemDao);
        this.todoItemDao = todoItemDao;
    }

   /* @Override
    //@Secured("ROLE_ADMIN")
    public void remove(Integer id) {
        this.todoItemDao.remove(id);
    }
    */

}
