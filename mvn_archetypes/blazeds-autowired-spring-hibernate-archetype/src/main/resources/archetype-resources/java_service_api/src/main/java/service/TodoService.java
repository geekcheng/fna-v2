package ${package}.service;

import ${package}.model.TodoItem;

public interface TodoService extends GenericManager<TodoItem, Integer> {

    void remove(Integer id);

}
