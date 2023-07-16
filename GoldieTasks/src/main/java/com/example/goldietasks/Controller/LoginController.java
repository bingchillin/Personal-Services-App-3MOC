package com.example.goldietasks.Controller;

import com.example.goldietasks.Model.DataProvider;
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
    private TextField txtUsername;
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
                        if(DataProvider.getInstance().checklogin(txtUsername.getText(),password)){
                            FXMLLoader loader = new FXMLLoader();
                            loader.setLocation(getClass().getResource("../Views/Home.fxml"));
                            Parent root = null;
                            try {
                                root = loader.load();
                            } catch (IOException e) {
                                e.printStackTrace();
                            }
                            hiddenText.setVisible(false);
                            Scene scene = new Scene(root);
                            //scene.getStylesheets().add(getClass().getResource("../Style/Light.css").toExternalForm());
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
        txtUsername.textProperty().addListener((observableValue, oldValue, newValue) ->{
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



