package com.example.goldietasks.Model;

public class UserSession {
    private static String loggedInUserId;

    public static void setLoggedInUserId(String userId) {
        loggedInUserId = userId;
    }

    public static String getLoggedInUserId() {
        return loggedInUserId;
    }
}
