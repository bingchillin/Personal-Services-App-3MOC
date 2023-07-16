package com.example.goldietasks.Model;

import org.json.simple.JSONObject;

import java.net.MalformedURLException;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Iterator;

public class DataProvider {
    private static DataProvider instance;
    private APIConnector apiConnector;

    String apiAuth = "http://localhost:3000/login";
    String apiTypetask = "http://localhost:3000/typetask";
    String apiTask = "http://localhost:3000/task";
    String apiUser = "http://localhost:3000/users";


    public static DataProvider getInstance() {
        if (instance == null) instance = new DataProvider();
        return instance;
    }

    private static void setInstance(DataProvider instance) {
        DataProvider.instance = instance;
    }

    public TypeTask getTypeTask(String name) throws SQLException, MalformedURLException {

        TypeTask typetask = new TypeTask();

        APIConnector apiConnectorTypeTask = new APIConnector(apiTypetask);

        JSONObject typeTaskJSONObject = apiConnectorTypeTask.getJSONObject("/" + name + "/");


        if (typeTaskJSONObject != null) {
            typetask.setName(typeTaskJSONObject.get("name").toString());
        }
        return typetask;
    }

    public TypeTask getTypeTaskById(int id) throws SQLException, MalformedURLException {

        TypeTask typetask = new TypeTask();

        APIConnector apiConnectorTypeTask = new APIConnector(apiTypetask);

        JSONObject typeTaskJSONObject = apiConnectorTypeTask.getJSONObject("/" + id + "/");


        if (typeTaskJSONObject != null) {
            typetask.setName(typeTaskJSONObject.get("name").toString());
        }
        return typetask;
    }

    public String checklogin(String email, String password) throws MalformedURLException {

        try {
            APIConnector apiConnector = new APIConnector(apiAuth);

            JSONObject requestObject = new JSONObject();
            requestObject.put("email", email);
            requestObject.put("password", password);

            System.out.println(requestObject);

            JSONObject response = apiConnector.postJSONObject("", requestObject);

            if (response != null && response.get("role") == "1") {
                return response.get("id").toString();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public ArrayList<TypeTask> getListType() throws SQLException, MalformedURLException {
        ArrayList<TypeTask> list = new ArrayList<>();

        APIConnector apiConnectorTypeTask = new APIConnector(apiTypetask);

        JSONObject typeTaskJSONObject = apiConnectorTypeTask.getJSONObject("");
        Iterator x = typeTaskJSONObject.keySet().iterator();

        while (x.hasNext()) {
            String key = (String) x.next();
            TypeTask typetask = new TypeTask();
            typetask.setName(typeTaskJSONObject.get("name").toString());
            list.add(typetask);
        }
        return list;
    }

    public boolean AddTask(Task task) throws SQLException {
        int result = 0;
        //TODO
        return result > 0;
    }

    public ArrayList<Task> getListTask(int userid) throws SQLException, MalformedURLException {
        ArrayList<Task> list = new ArrayList<>();

        APIConnector apiConnectorTask = new APIConnector(apiTask);

        JSONObject taskJSONObject = apiConnectorTask.getJSONObject("/user/" + userid + "/");
        if (taskJSONObject != null){
            Iterator x = taskJSONObject.keySet().iterator();
            while (x.hasNext()) {
                String key = (String) x.next();
                Task task = new Task();
                task.setId((Integer) taskJSONObject.get("id"));
                task.setTitle(taskJSONObject.get("title").toString());
                task.setType(DataProvider.getInstance().getTypeTaskById((Integer) taskJSONObject.get("type")));
                task.setContent(taskJSONObject.get("description").toString());
                list.add(task);
            }
            return list;
        }
        return list;

    }

    public boolean DelTask(String id) throws SQLException {
        int result = 0;
        //TODO
        return result > 0;
    }

    public Task getTask(String id) throws SQLException, MalformedURLException {

        Task myTask = new Task();

        APIConnector apiConnectorTask = new APIConnector(apiTask);

        JSONObject taskJSONObject = apiConnectorTask.getJSONObject("/" + id + "/");

        if (taskJSONObject != null) {
            myTask.setId((Integer) taskJSONObject.get("id"));
            myTask.setTitle(taskJSONObject.get("title").toString());
            myTask.setType(DataProvider.getInstance().getTypeTaskById((Integer) taskJSONObject.get("type")));
            myTask.setContent(taskJSONObject.get("description").toString());
        }

        return myTask;
    }

    public boolean EditTask(Task task) throws SQLException {
        int result = 0;

        /// TODO

        return result > 0;
    }



}
