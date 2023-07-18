package com.example.goldietasks.Controller;

import com.example.goldietasks.Model.TypeTask;
import javafx.fxml.FXML;
import javafx.scene.control.Label;
import javafx.scene.input.MouseEvent;

public class TypeTaskController {
    @FXML
    private Label name;

    private HomeController homeController;

    public void setHomeController(HomeController homeController) {
        this.homeController = homeController;
    }

    public void fillData(TypeTask t){
        name.setText(t.getName());
    }
    public void ShowType(MouseEvent event){
        if(!name.getText().equals("New Type"))
            homeController.ShowTaskInType(name.getText());
    }

}
