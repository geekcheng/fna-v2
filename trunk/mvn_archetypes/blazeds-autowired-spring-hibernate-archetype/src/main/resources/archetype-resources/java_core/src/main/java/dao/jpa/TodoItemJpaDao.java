package ${package}.dao.jpa;

import org.springframework.stereotype.Repository;

import ${package}.dao.TodoItemDao;
import ${package}.model.TodoItem;

@Repository("todoItemDao")
public class TodoItemJpaDao extends GenericDaoJpa<TodoItem, Integer>
    implements TodoItemDao {

    public TodoItemJpaDao() {
        super(TodoItem.class);
    }

}