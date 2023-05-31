
package com.example.goldie.controller;

import com.example.goldie.model.CardModel;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.ContextMenu;
import javafx.scene.control.Label;
import javafx.scene.control.MenuItem;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import com.example.goldie.utilities.Constants;

import java.net.URL;
import java.util.Objects;
import java.util.ResourceBundle;
public class CardController implements Initializable {

    @FXML
    private ImageView iconSelect;

    @FXML
    private Label lblCardName;

    @FXML
    private Button btnInfo;

    /**
     * Initializes the controller class.
     *
     * @param url
     * @param rb
     */
    @Override
    public void initialize(URL url, ResourceBundle rb) {
        // TODO
    }

    public void setCard(CardModel model) {
        ContextMenu menu = new ContextMenu();
        System.out.println(model.toString());
        lblCardName.setText(model.getTitle());

        if (model.isCompleted()) {
            btnInfo.setText("Terminée");
            iconSelect.setImage(new Image(Objects.requireNonNull(getClass().getResourceAsStream(Constants.ICON_CHECK))));
            menu.getItems().add(new MenuItem("La tâche est finie"));
        } else {
            btnInfo.setText("En cours");
            iconSelect.setImage(new Image(Objects.requireNonNull(getClass().getResourceAsStream(Constants.ICON_NOTCHECKED))));
            menu.getItems().add(new MenuItem("La tâche n'est pas finie"));
        }

        lblCardName.setContextMenu(menu);
    }

}
