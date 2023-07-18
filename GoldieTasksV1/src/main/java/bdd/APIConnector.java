package bdd;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

public class APIConnector {
    private final String apiUrl;

    public APIConnector(String apiUrl) {
        this.apiUrl = apiUrl;
    }

    public String get(String endpoint) {
        return sendRequest("GET", endpoint, null);
    }

    public String post(String endpoint, String requestBody) {
        return sendRequest("POST", endpoint, requestBody);
    }

    public String put(String endpoint, String requestBody) {
        return sendRequest("PUT", endpoint, requestBody);
    }

    public String delete(String endpoint) {
        return sendRequest("DELETE", endpoint, null);
    }

    private String sendRequest(String method, String endpoint, String requestBody) {
        try {
            URL url = new URL(apiUrl + endpoint);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod(method);

            if (requestBody != null) {
                connection.setRequestProperty("Content-Type", "application/json");
                connection.setDoOutput(true);
                OutputStream outputStream = connection.getOutputStream();
                outputStream.write(requestBody.getBytes("UTF-8"));
                outputStream.close();
            }

            int responseCode = connection.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
                StringBuilder response = new StringBuilder();
                String line;
                while ((line = reader.readLine()) != null) {
                    response.append(line);
                }
                reader.close();
                return response.toString();
            } else {
                System.out.println("Request failed with response code: " + responseCode);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
