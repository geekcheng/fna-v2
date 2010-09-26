package com.adobe.txi.todo.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.TableGenerator;

@Entity(name = "todo")
public class TodoItem implements Serializable
{
    private static final long serialVersionUID = 5750553524796306885L;

    private Integer id;

    private String title;

    @Id
    @GeneratedValue(strategy = GenerationType.TABLE, generator = "generatorName")
    @TableGenerator(name = "generatorName", table = "TableID", pkColumnName = "tablename", valueColumnName = "id", allocationSize = 1)
    public Integer getId()
    {
        return id;
    }

    public void setId(Integer id)
    {
        this.id = id;
    }

    @Column(name = "title", nullable = false, length = 50)
    public String getTitle()
    {
        return title;
    }

    public void setTitle(String title)
    {
        this.title = title;
    }

}