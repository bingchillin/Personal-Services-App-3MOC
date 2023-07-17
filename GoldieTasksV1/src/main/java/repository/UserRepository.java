package repository;

import bdd.APIConnector;
import modele.User;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

public class UserRepository {

    public UserRepository() {

    }


    public User connexion(String email, String password) {
        User user = null;
        String endpoint = "login";

        try {
            APIConnector apiConnector = new APIConnector("http://localhost:3000/");
            JSONObject requestBody = new JSONObject();
            requestBody.put("email", email);
            requestBody.put("password", password);

            String response = apiConnector.post(endpoint, requestBody.toString());

            if (response != null) {
                JSONObject jsonResponse = (JSONObject) JSONValue.parse(response);
                Object idObject = jsonResponse.get("id");
                if (idObject != null) {
                    int userId = ((Long) idObject).intValue();
                    user = new User(userId);
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }
}