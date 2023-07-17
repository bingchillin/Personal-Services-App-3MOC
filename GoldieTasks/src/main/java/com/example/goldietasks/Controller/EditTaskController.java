package com.example.goldietasks.Controller;

import com.example.goldietasks.Model.DataProvider;
import com.example.goldietasks.Model.Task;
import com.example.goldietasks.Model.TypeTask;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.*;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.VBox;
import javafx.stage.Stage;

import java.net.MalformedURLException;
import java.net.URL;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.ResourceBundle;

public class EditTaskController implements Initializable {

    private Task task;

    public void setTask(Task task) {
        this.task = task;
    }
    @FXML
    private TextField txtTitle;
    @FXML
    private ComboBox CmbType;
    @FXML
    private TextArea txtContent;
    @FXML
    private Label labelTitles;
    @FXML
    private VBox MyForm;

    private Stage thisStage;
    private HomeController homeController;

    public void setHomeController(HomeController homeController) {
        this.homeController = homeController;
    }

    public void setThisStage(Stage thisStage) {
        this.thisStage = thisStage;
    }

    private static double xOffset = 0;
    private static double yOffset = 0;

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        try {
            ArrayList<TypeTask> list = DataProvider.getInstance().getListType();
            for(TypeTask typeTask:list){
                CmbType.getItems().add(typeTask.getName());
            }
            MyForm.setOnMousePressed(new EventHandler<MouseEvent>() {
                @Override
                public void handle(MouseEvent event) {
                    xOffset = thisStage.getX() - event.getScreenX();
                    yOffset = thisStage.getY() - event.getScreenY();
                }
            });
            MyForm.setOnMouseDragged(new EventHandler<MouseEvent>() {
                @Override
                public void handle(MouseEvent event) {
                    thisStage.setX(event.getScreenX() + xOffset);
                    thisStage.setY(event.getScreenY() + yOffset);
                }
            });

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } catch (MalformedURLException e) {
            throw new RuntimeException(e);
        }

    }

    public void filldataTask() {
        CmbType.setValue(task.getType().getName());
        this.txtTitle.setText(task.getTitle());
        this.txtContent.setText(task.getContent());
    }

    public void CloseFrame(ActionEvent event){
        Button btn = (Button) event.getSource();
        Stage stage =(Stage) btn.getScene().getWindow();
        stage.close();

    }
    public void Submit(ActionEvent event) throws SQLException, MalformedURLException {
        if(checkInput()){
            task.setTitle(txtTitle.getText());
            task.setContent(txtContent.getText());
            task.setType(DataProvider.getInstance().getTypeTask(CmbType.getSelectionModel().getSelectedItem().toString()));

            if(DataProvider.getInstance().EditTask(task)){
                homeController.refeshData();
                Button btn = (Button) event.getSource();
                Stage stage =(Stage) btn.getScene().getWindow();
                stage.close();
            }
        }
    }

    private boolean checkInput() {
        if(txtTitle.getText().equals("")){
            labelTitles.getStyleClass().add("error");
            return false;
        }
        return true;
    }
}
