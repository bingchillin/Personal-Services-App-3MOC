package modele;

public class User {
    private int idUser;


    public User(int idUser) {
        this.idUser = idUser;
    }
    public User() {}

    public int getIdUser() {
        return idUser;
    }
    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }
    @Override
    public String toString() {
        return Integer.toString(this.idUser);
    }

}
