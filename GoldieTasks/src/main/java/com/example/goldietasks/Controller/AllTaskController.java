package com.example.goldietasks.Controller;

import com.example.goldietasks.Model.Task;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Node;
import javafx.scene.control.Label;
import javafx.scene.layout.VBox;

import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;
import java.util.ResourceBundle;

public class AllTaskController implements Initializable {
    @FXML
    private VBox ListAllTask;
    @FXML
    private Label NameView;
    public void setViewName(String str){
        NameView.setText(str);
    }
    private ArrayList<Task> list;

    public void setList(ArrayList<Task> list) {
        this.list = list;
    }
    private HomeController homeController;

    public void setHomeController(HomeController homeController) {
        this.homeController = homeController;
    }

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        fillList();
    }
    public void DelItem(Node n){
        ListAllTask.getChildren().remove(n);
        homeController.refeshData();
    }
    public void fillList() {
        ArrayList<Node> listnode = new ArrayList<>();
        for(Task t : list){
            try {
                FXMLLoader loader = new FXMLLoader(getClass().getResource("TaskItem.fxml"));
                Node node = loader.load();
                TaskItem control = loader.getController();
                control.FillData(t);
                control.setAllTaskController(this);
                control.setHomeController(homeController);
                listnode.add(node);

            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        ListAllTask.getChildren().addAll(listnode);
    }

    public void EditItem() {
        homeController.refeshData();
    }
}
