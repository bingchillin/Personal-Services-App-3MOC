package repository;

import bdd.APIConnector;
import modele.Task;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

import java.util.ArrayList;
import java.util.List;

public class TaskRepository {
    public TaskRepository(){

    }

    public void sauvegarder(Task task) {
        String endpoint = "tasks";
        try {
            APIConnector apiConnector = new APIConnector("http://localhost:3000/");
            JSONObject requestBody = new JSONObject();
            requestBody.put("type", task.getType());
            requestBody.put("title", task.getTitle());
            requestBody.put("content", task.getContent());
            requestBody.put("user_id",task.getUserid());

            String response = apiConnector.post(endpoint, requestBody.toString());

            if (response != null) {
                JSONObject responseJson = (JSONObject) JSONValue.parse(response);
                System.out.println("response" + responseJson);
                System.out.println("response get" + responseJson.get("id"));
                System.out.println("Long get" + ((Long) responseJson.get("id")).intValue());
                int taskId = ((Long) responseJson.get("id")).intValue();
                task.setId(taskId);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }



    public List<Task> getTasksByUserId(int userId) {
        String endpoint = "tasks/user/" + userId;

        try {
            APIConnector apiConnector = new APIConnector("http://localhost:3000/");
            String response = apiConnector.get(endpoint);

            if (response != null) {
                JSONArray jsonArray = (JSONArray) JSONValue.parse(response);
                List<Task> tasks = new ArrayList<>();

                for (Object jsonElement : jsonArray) {
                    JSONObject jsonObject = (JSONObject) jsonElement;
                    Task task = new Task();
                    task.setId(((Long) jsonObject.get("id")).intValue());
                    task.setUserid(((Long) jsonObject.get("user_id")).intValue());
                    task.setType(((Long) jsonObject.get("type")).intValue());
                    task.setTitle((String) jsonObject.get("title"));
                    task.setContent((String) jsonObject.get("content"));

                    tasks.add(task);
                }

                return tasks;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public void deleteTask(Task task) {
        String endpoint = "tasks/" + task.getId();

        try {
            APIConnector apiConnector = new APIConnector("http://localhost:3000/");
            String response = apiConnector.delete(endpoint);

            if (response != null) {
                System.out.println("Task deleted successfully");
            } else {
                System.out.println("Failed to delete task");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }




}
