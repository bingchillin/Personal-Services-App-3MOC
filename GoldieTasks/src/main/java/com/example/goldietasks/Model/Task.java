package com.example.goldietasks.Model;


import java.time.LocalDate;
import java.time.LocalTime;

public class Task {
    private int id;
    private TypeTask type;
    private String title;
    private String content;

    public Task() {
    }

    public Task(int id, TypeTask type, String title, String content) {
        this.id = id;
        this.type = type;
        this.title = title;
        this.content = content;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public TypeTask getType() {
        return type;
    }

    public void setType(TypeTask type) {
        this.type = type;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}