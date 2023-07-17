package appli.user;

import appli.StartApplication;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import modele.Task;
import modele.User;
import repository.TaskRepository;

import java.net.URL;
import java.util.ResourceBundle;

public class Form implements Initializable {


    @FXML
    private TextField fldTitle;

    @FXML
    private TextField fldType;

    @FXML
    private TextField fldContent;

    @FXML
    private Label lblErreur;

    private Task task;
    private User userConnecte;

    public Form(User userConnecte) {
        this.userConnecte = userConnecte;
    }

    public Form(User userConnecte, Task task) {
        this.task = task;
        this.userConnecte = userConnecte;

    }

    @FXML
    void SaveAction(ActionEvent event) {
        TaskRepository taskRepository = new TaskRepository();
        if (task == null) {
            task = new Task(Integer.parseInt(fldType.getText()), userConnecte.getIdUser(), fldTitle.getText(), fldContent.getText());
            taskRepository.sauvegarder(task);
            StartApplication.changeScene("/appli/user/Accueil", new Accueil(this.userConnecte));

        } else {
            this.task.setTitle(fldTitle.getText());
            this.task.setType(Integer.parseInt(fldType.getText()));
            this.task.setContent(fldContent.getText());
            taskRepository.sauvegarder(task);
            StartApplication.changeScene("/appli/user/Accueil", new Accueil(this.userConnecte));
        }


    }

    @FXML
    void backAction(ActionEvent event) {
        StartApplication.changeScene("/appli/user/Accueil", new Accueil(this.userConnecte));
    }

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        if (this.task != null) {
            fldTitle.setText(this.task.getTitle());
            fldType.setText(Integer.toString(this.task.getType()));
            fldContent.setText(this.task.getContent());
        }
    }
}
