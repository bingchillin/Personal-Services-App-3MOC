package appli.user;

import appli.StartApplication;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.*;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.input.MouseEvent;
import modele.Task;
import modele.User;
import repository.TaskRepository;
import repository.UserRepository;

import java.net.URL;
import java.sql.SQLException;
import java.util.Optional;
import java.util.ResourceBundle;

public class Accueil implements Initializable {

    @FXML
    private TableView<Task> tbl;

    @FXML
    private Button btnAdd;

    @FXML
    private Button btnDelete;

    @FXML
    private Button btnModif;

    private User user;
    private Task taskSelected;

    public Accueil(User u) {
        this.user = u;
        System.out.println("Accueil" + u);
    }

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        String[][] colonnes = {
                {"Id","id"},
                {"User","userid"},
                {"Type","type"},
                {"Titre","title"},
                {"Description","content"},
        };
        for (int i = 0 ; i < colonnes.length ; i ++){
            TableColumn<Task,String> myTable= new TableColumn<>(colonnes[i][0]);
            myTable.setCellValueFactory(new PropertyValueFactory<Task,String>(colonnes[i][1]));
            tbl.getColumns().add(myTable);
        }
        TaskRepository taskRepository = new TaskRepository();
        System.out.println(taskRepository.getTasksByUserId(user.getIdUser()));

        if(taskRepository.getTasksByUserId(user.getIdUser()) != null) {
            tbl.getItems().addAll(taskRepository.getTasksByUserId(user.getIdUser()));
        }

    }
    @FXML
    void AddAction(ActionEvent event) {
        StartApplication.changeScene("/appli/user/form",new Form(this.user));
    }

    @FXML
    void delAction(ActionEvent event) throws SQLException {
        Optional<ButtonType> resultat = StartApplication.validationDialog("Supression d'une tâche","êtes-vous sûr de vouloir supprimer la tache : "+this.taskSelected);
        if (resultat.get() == ButtonType.OK){
            TaskRepository taskRepository = new TaskRepository();
            taskRepository.deleteTask(this.taskSelected);
            tbl.getItems().remove(this.taskSelected);

        }
    }

    @FXML
    void editAction(ActionEvent event) {
        StartApplication.changeScene("/appli/user/form",new Form(this.user,this.taskSelected));
    }

    @FXML
    void onSelIntem(MouseEvent event) {
        System.out.println("hey ! ");
        this.taskSelected = tbl.getSelectionModel().getSelectedItem();
        if (taskSelected != null){
            btnDelete.setDisable(false);
            btnModif.setDisable(false);
        }else{
            btnDelete.setDisable(true);
            btnModif.setDisable(true);
        }
    }

    @FXML
    void menuAction(ActionEvent event) {
        System.out.println("hey !");
    }

    @FXML
    void deconnecterAction(ActionEvent event) {
        StartApplication.changeScene("/appli/user/login");

    }


}
