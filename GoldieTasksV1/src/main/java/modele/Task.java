package modele;

public class Task {
    private int id;
    private int type;
    private String title;
    private String content;

    public Task(int id, int type, String title, String content) {
        this.id = id;
        this.type = type;
        this.title = title;
        this.content = content;
    }

    public Task(int type, String title, String content) {
        this.type = type;
        this.title = title;
        this.content = content;
    }

    public Task() {}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
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

    @Override
    public String toString() {
        return "Task{" +
                "id=" + id +
                ", type=" + type +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                '}';
    }
}
