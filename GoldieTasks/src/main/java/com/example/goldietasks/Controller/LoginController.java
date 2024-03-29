package com.example.goldietasks.Controller;

import com.example.goldietasks.Main;
import com.example.goldietasks.Model.DataProvider;
import com.example.goldietasks.Model.UserSession;
import javafx.concurrent.Task;
import javafx.concurrent.WorkerStateEvent;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.scene.control.PasswordField;
import javafx.scene.control.ProgressBar;
import javafx.scene.control.TextField;
import javafx.scene.input.KeyEvent;
import javafx.stage.Stage;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ResourceBundle;

public class LoginController implements Initializable {
    @FXML
    private TextField txtEmail;
    @FXML
    private PasswordField txtPassword;
    @FXML
    private Label hiddenText;
    @FXML
    private ProgressBar processBar;

    private String password="";
    private Boolean checkName,checkPass;
    public void CheckLogin(ActionEvent event) throws InterruptedException {
        if(checkName && checkPass){
            Task<Void> sleeper = new Task<Void>() {
                @Override
                protected Void call() throws Exception {
                    try {
                        processBar.setVisible(true);
                        hiddenText.setVisible(false);
                        Thread.sleep(1500);
                    } catch (InterruptedException e) {
                    }
                    return null;
                }
            };
            sleeper.setOnSucceeded(new EventHandler<WorkerStateEvent>() {
                @Override
                public void handle(WorkerStateEvent evt) {
                    try {
                        System.out.println(txtEmail.getText());
                        System.out.println(txtPassword.getText());
                        String userId = DataProvider.getInstance().checklogin(txtEmail.getText(),txtPassword.getText());
                        //String userId = "2";
                        if(userId != null){
                            UserSession.setLoggedInUserId(userId);
                            FXMLLoader loader = new FXMLLoader(Main.class.getResource("Home.fxml"));
                            hiddenText.setVisible(false);
                            Scene scene = new Scene(loader.load());
                            Stage stage = (Stage) ((Node)event.getSource()).getScene().getWindow();
                            stage.setResizable(true);
                            stage.setTitle("GoldieTasks - Liste des taches");
                            stage.setScene(scene);
                            HomeController homeController = loader.getController();
                            homeController.setThisStage(stage);
                            stage.centerOnScreen();
                        }else {
                            hiddenText.setText("Echec de la connexion !");
                            hiddenText.setVisible(true);
                            processBar.setVisible(false);
                        }
                    } catch (MalformedURLException e) {
                        throw new RuntimeException(e);
                    } catch (IOException e) {
                        throw new RuntimeException(e);
                    }

                }
            });
            new Thread(sleeper).start();
        }else {
            hiddenText.setText("Il manque des champs");
            hiddenText.setVisible(true);
        }


    }

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        hiddenText.setVisible(false);
        processBar.setVisible(false);
        checkName=false;
        checkPass=false;
        txtEmail.textProperty().addListener((observableValue, oldValue, newValue) ->{
            if(newValue.trim().equals("")){
                checkName = false;
            }else{
                checkName=true;
                hiddenText.setVisible(false);

            }
        } );
        txtPassword.textProperty().addListener((observableValue, oldValue, newValue) ->{
            password = newValue;
            if(newValue.trim().equals("")){
                checkPass = false;
            }else {
                checkPass=true;
                hiddenText.setVisible(false);
            }
        } );
    }

    public void changeText(KeyEvent keyEvent) {
        if(txtPassword.getText().equals("")){
            txtPassword.setPromptText("Password");
        }
    }
}



