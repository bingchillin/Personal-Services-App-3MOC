package com.example.goldietasks.Controller;

import com.example.goldietasks.Model.DataProvider;
import com.example.goldietasks.Model.Task;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.AnchorPane;
import javafx.scene.paint.Color;
import javafx.stage.Modality;
import javafx.stage.Stage;
import javafx.stage.StageStyle;

import java.io.IOException;
import java.net.URL;
import java.sql.SQLException;
import java.time.format.DateTimeFormatter;
import java.util.ResourceBundle;

public class TaskItem implements Initializable {
    @FXML
    private Label type,title,content,date,time;
    @FXML
    private AnchorPane mainTask;

    private AllTaskController allTaskController;
    private HomeController homeController;

    public void setHomeController(HomeController homeController) {
        this.homeController = homeController;
    }

    public void setAllTaskController(AllTaskController allTaskController) {
        this.allTaskController = allTaskController;
    }

    public void FillData(Task t) {
        type.setText(t.getType().getName());
        title.setText(t.getTitle());
        content.setText(t.getContent());
        mainTask.setAccessibleText(String.valueOf(t.getId()));
    }

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
    }
    public void Delete(MouseEvent event) throws SQLException {
        if(DataProvider.getInstance().DelTask(mainTask.getAccessibleText())){
            allTaskController.DelItem(mainTask);
        }
    }
    public void Edit(MouseEvent event){
        try {
            FXMLLoader loader = new FXMLLoader();
            loader.setLocation(getClass().getResource("EditTask.fxml"));
            Parent pr = loader.load();
            EditTaskController controller = loader.getController();
            controller.setTask(DataProvider.getInstance().getTask(mainTask.getAccessibleText()));
            controller.filldataTask();
            Scene scene = new Scene(pr,365,470);
            scene.getStylesheets().add(homeController.getThisStage().getScene().getStylesheets().get(0));
            scene.setFill(Color.TRANSPARENT);

            Stage stage = new Stage();
            stage.setResizable(false);
            stage.setScene(scene);
            stage.initStyle(StageStyle.TRANSPARENT);
            stage.initOwner(((Node)event.getSource()).getScene().getWindow());
            stage.initModality(Modality.APPLICATION_MODAL);
            controller.setThisStage(stage);
            controller.setHomeController(homeController);
            stage.showAndWait();

        } catch (IOException | SQLException e) {
            e.printStackTrace();
        }
    }
}
