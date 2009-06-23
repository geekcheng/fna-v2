package ${groupId}.dao.jpa;

import org.springframework.stereotype.Repository;

import ${groupId}.dao.TodoItemDao;
import ${groupId}.model.TodoItem;

@Repository("todoItemDao")
public class TodoItemJpaDao extends GenericDaoJpa<TodoItem, Integer>
    implements TodoItemDao {

    public TodoItemJpaDao() {
        super(TodoItem.class);
    }

}