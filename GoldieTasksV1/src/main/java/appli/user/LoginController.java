package appli.user;

import appli.StartApplication;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Label;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import modele.User;
import repository.UserRepository;

public class LoginController {

    @FXML
    private TextField fldEmail;

    @FXML
    private PasswordField fldMotDePasse;

    @FXML
    private Label lblErreur;

    @FXML
    void seConnecterAction(ActionEvent event) {
        System.out.println(fldEmail.getText());
        System.out.println(fldMotDePasse.getText());
        UserRepository userRepository = new UserRepository();
        User u = userRepository.connexion(fldEmail.getText(),fldMotDePasse.getText());
        System.out.println("login controller" + u);
        if(u != null){
            StartApplication.changeScene("/appli/user/accueil",new Accueil(u));
            System.out.println("User connecté");
        }else{
            System.out.println("erreur");
            lblErreur.setText("erreur");
        }
    }

}
