package com.example.goldietasks.Model;

public class TypeTask {

    private int id;
    private String name;

    public TypeTask(int id, String name) {
        this.id = id;
        this.name = name;
    }

    public TypeTask() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

}
