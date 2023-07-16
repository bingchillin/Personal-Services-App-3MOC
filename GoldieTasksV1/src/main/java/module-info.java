module appli.user {
    requires javafx.controls;
    requires javafx.fxml;
    requires javafx.web;
    requires javafx.base;

    requires org.controlsfx.controls;
    requires com.dlsc.formsfx;
    requires validatorfx;
    requires org.kordamp.ikonli.javafx;
    requires org.kordamp.bootstrapfx.core;
    requires eu.hansolo.tilesfx;
    requires java.sql;
    requires java.mail;
    requires activation;
    requires json.simple;

    opens appli.user to javafx.fxml;
    exports appli;
    opens appli to javafx.fxml;
    opens modele to javafx.base;
}