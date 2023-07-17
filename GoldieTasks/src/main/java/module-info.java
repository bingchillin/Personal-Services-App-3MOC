module com.example.goldietasks {
    requires javafx.controls;
    requires javafx.fxml;
    requires java.sql;
    requires json.simple;


    opens com.example.goldietasks to javafx.fxml;
    exports com.example.goldietasks;
    exports com.example.goldietasks.Controller;
    opens com.example.goldietasks.Controller to javafx.fxml;
}