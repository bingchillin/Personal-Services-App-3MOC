package com.example.goldietasks.Controller;

import com.example.goldietasks.Model.DataProvider;
import com.example.goldietasks.Model.Task;
import com.example.goldietasks.Model.TypeTask;
import com.example.goldietasks.Model.UserSession;
import javafx.animation.TranslateTransition;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.scene.control.ScrollPane;
import javafx.scene.control.TextField;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;
import javafx.scene.paint.Color;
import javafx.stage.Modality;
import javafx.stage.Stage;
import javafx.stage.StageStyle;
import javafx.util.Duration;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.ResourceBundle;

public class HomeController implements Initializable {
    @FXML
    private BorderPane mainPanel;
    @FXML
    private VBox leftMenuPanel,VBoxType;
    @FXML
    private ScrollPane labelListPanel,NotificationPanel,SettingPanel;
    @FXML
    private HBox btnAllTast,btnToday,btnCalender2,btnLateTask,SideRight;
    @FXML
    private Label CountTaskToday,CountTaskLate;
    @FXML
    private TextField txtSearch;

    private int menuindex;
    private String menuTypeTaskLabe;
    private ArrayList<Task> listTasks;
    private  ArrayList<Task> SearchList;
    private  Stage thisStage;
    public void setThisStage(Stage thisStage) {
        this.thisStage = thisStage;
    }

    public Stage getThisStage() {
        return thisStage;
    }

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        menuindex=0;
        refeshData();
        fillTypeList();
        SideRight.setPrefWidth(0);
        SettingPanel.setPrefWidth(0);
        txtSearch.textProperty().addListener((observableValue, oldValue, newValue) ->{
            showSearch(newValue);
        } );
    }

    public void showSearch(String str){
        SearchList = new ArrayList<>();
        AllTaskController controller = addToPanel("AllTask").getController();
        controller.setViewName("Search: "+str);
        if(str.trim().equals("")){
            defaultView();
            return;
        }else {
            for(Task t: listTasks){
                if(str.substring(0,1).equals("#") && str.length()>1){
                    String strSub=str.substring(1).toLowerCase();
                    if(t.getType().getName().toLowerCase().matches("(.*)"+strSub+"(.*)")){
                        SearchList.add(t);
                    }
                }else {
                    str=str.toLowerCase();
                    if(t.getTitle().toLowerCase().matches("(.*)"+str+"(.*)") || t.getContent().toLowerCase().matches("(.*)"+str+"(.*)")){
                        SearchList.add(t);
                    }
                }
            }
        }
        controller.setList(SearchList);
        controller.setHomeController(this);
        controller.fillList();
        menuindex=5;
    }
    public void fillTypeList() {
        ArrayList<TypeTask> listType;
        VBoxType.getChildren().clear();
        try {
            listType = DataProvider.getInstance().getListType();
            for (TypeTask typeTask:listType){
                FXMLLoader loader = new FXMLLoader();
                loader.setLocation(getClass().getResource("TypeTask.fxml"));
                Node node = loader.load();
                TypeTaskController control  = loader.getController();
                control.setHomeController(this);
                control.fillData(typeTask);
                VBoxType.getChildren().add(node);
            }
            FXMLLoader loader = new FXMLLoader();
            loader.setLocation(getClass().getResource("TypeTask.fxml"));
            Node node = loader.load();
            TypeTaskController control  = loader.getController();
            control.setHomeController(this);
            VBoxType.getChildren().add(node);
        } catch (SQLException | IOException throwables) {
            throwables.printStackTrace();
        }
    }

    public void defaultView() {
        FXMLLoader loader = addToPanel("AllTask");
        AllTaskController controller = loader.getController();
       // AllTaskController controller = addToPanel("AllTask").getController();
        controller.setList(listTasks);
        controller.setHomeController(this);
        controller.fillList();
        controller.setViewName("All Task");
        menuindex=0;
        btnAllTast.getStyleClass().add("MenuActive");
    }


    public FXMLLoader addToPanel (String layoutName){
        Parent rootPanel = null;
        FXMLLoader loader = new FXMLLoader();
        try{
            loader.setLocation(getClass().getResource(layoutName+".fxml"));
            rootPanel = loader.load();
            for(Node node: leftMenuPanel.getChildren()){
                node.getStyleClass().remove("MenuActive");
            }

        }catch (Exception ex){
            ex.printStackTrace();
        }
        mainPanel.setCenter(rootPanel);
        return loader;
    }

    public void AddTaskShow(MouseEvent event){
        try {
            FXMLLoader loader = new FXMLLoader();
            loader.setLocation(getClass().getResource("AddTask.fxml"));
            Parent pr = loader.load();
            AddTaskController controller = loader.getController();
            controller.setHomeController(this);
            Scene scene = new Scene(pr,365,470);
            scene.getStylesheets().add(thisStage.getScene().getStylesheets().get(0));
            scene.setFill(Color.TRANSPARENT);
            Stage stage = new Stage();
            stage.setResizable(false);
            stage.setScene(scene);
            stage.initStyle(StageStyle.TRANSPARENT);
            stage.initOwner(thisStage);
            stage.initModality(Modality.APPLICATION_MODAL);
            controller.setThisStage(stage);
            stage.showAndWait();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    public void ShowAllTask(MouseEvent event){
        AllTaskController controller = addToPanel("AllTask").getController();
        controller.setList(listTasks);
        controller.setHomeController(this);
        controller.setViewName("All Task");
        controller.fillList();
        Node node = (Node) event.getSource();
        node.getStyleClass().add("MenuActive");
        menuindex=0;
    }
    public void ShowCatalog(MouseEvent event){
        if(labelListPanel.isVisible()){
            labelListPanel.setVisible(false);

        }else {
            labelListPanel.setVisible(true);
        }
    }
    public void refeshData(){
        try {
            listTasks = DataProvider.getInstance().getListTask(Integer.parseInt(UserSession.getLoggedInUserId()));
        } catch (SQLException | MalformedURLException throwables) {
            throwables.printStackTrace();
        }
        switch (menuindex){
            case 0:defaultView();break;
            case 4:ShowTaskInType(menuTypeTaskLabe);break;
            case 5:showSearch(txtSearch.getText());break;
        }
    }
    public  void ShowTaskInType(String typeName){
        ArrayList<Task> listTasksType = new ArrayList<>();
        for(Task t:listTasks){
            if(t.getType().getName().equals(typeName)) {
                listTasksType.add(t);
            }
        }
        AllTaskController controller = addToPanel("AllTask").getController();
        controller.setList(listTasksType);
        controller.setHomeController(this);
        controller.setViewName("#"+typeName);
        controller.fillList();
        menuindex=4;
        menuTypeTaskLabe=typeName;
    }

    public void LoginOut(ActionEvent event) throws IOException {
        Parent root = FXMLLoader.load(getClass().getResource("Login.fxml"));
        Scene scene = new Scene(root,900,600);
        Stage stage = (Stage) ((Node)event.getSource()).getScene().getWindow();
        stage.setTitle("Login");
        stage.setResizable(false);
        stage.setScene(scene);
        stage.centerOnScreen();
    }
}
