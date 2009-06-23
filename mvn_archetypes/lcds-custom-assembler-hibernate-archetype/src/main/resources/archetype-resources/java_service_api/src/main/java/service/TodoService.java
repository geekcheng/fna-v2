package ${groupId}.service;

import ${groupId}.model.TodoItem;

public interface TodoService extends GenericManager<TodoItem, Integer> {

    void remove(Integer id);

}
