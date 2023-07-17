package repository;

import bdd.APIConnector;
import modele.User;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.FutureTask;

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

            Callable<String> apiCall = () -> apiConnector.post(endpoint, requestBody.toString());
            FutureTask<String> futureTask = new FutureTask<>(apiCall);

            Thread thread = new Thread(futureTask);
            thread.start();

            try {
                String response = futureTask.get();

                if (response != null) {
                    JSONObject jsonResponse = (JSONObject) JSONValue.parse(response);
                    JSONObject userObject = (JSONObject) jsonResponse.get("user");
                    Object idObject = userObject.get("id");

                    if (idObject != null) {
                        int userId = ((Long) idObject).intValue();
                        user = new User(userId);
                        System.out.println(user);
                    }
                }
            } catch (InterruptedException | ExecutionException e) {
                e.printStackTrace();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

  /*  public User connexion(String email, String password) {
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
                JSONObject userObject = (JSONObject) jsonResponse.get("user");
                Object idObject = userObject.get("id");

                if (idObject != null) {
                    int userId = ((Long) idObject).intValue();
                    user = new User(userId);
                    System.out.println(user);
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

   */
}
