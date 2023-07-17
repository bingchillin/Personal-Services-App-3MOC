package modele;

public class Task {
    private int id;
    private int userid;
    private int type;
    private String title;
    private String content;

    public Task(int id, int userid, int type, String title, String content) {
        this.id = id;
        this.userid = userid;
        this.type = type;
        this.title = title;
        this.content = content;
    }

    public Task(int type, int userid, String title, String content) {
        this.type = type;
        this.userid = userid;
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
    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
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
                ", userid=" + userid +
                ", type=" + type +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                '}';
    }
}
