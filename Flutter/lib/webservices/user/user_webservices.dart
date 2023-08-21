import 'package:flutter/material.dart';
import 'package:goldie_studio/webservices/user/user_class.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserWebServices {
  static Future<List<User>> getAllUsers() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/users'));
      switch (response.statusCode) {
        case 200:
          final List<dynamic> usersJson =
              json.decode(response.body) as List<dynamic>;

          return usersJson.map((userJson) {
            return User.fromJson(userJson as Map<String, dynamic>);
          }).toList();
        default:
          throw Exception('Failed to load users');
      }
    } catch (error) {
      debugPrint('Error getting all users : $error');
      rethrow;
    }
  }

  // delete user
  static Future<bool> deleteUser(int id) async {
    try {
      final response =
          await http.delete(Uri.parse('http://localhost:3000/users/$id'));
      switch (response.statusCode) {
        case 200:
          return true;
        case 204:
          return true;
        default:
          debugPrint(response.statusCode.toString());
          throw Exception('Failed to delete user');
      }
    } catch (error) {
      debugPrint('Error deleting user : $error');
      rethrow;
    }
  }

  // update user
  static Future<void> updateUser(User user) async {
    try {
      final response = await http.put(
        Uri.parse('http://localhost:3000/users/${user.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(user.toJson()),
      );
      switch (response.statusCode) {
        case 200:
          return;
        default:
          debugPrint(response.statusCode.toString());
          throw Exception('Failed to update user');
      }
    } catch (error) {
      debugPrint('Error updating user : $error');
      rethrow;
    }
  }

  // create user
  static Future<void> createUser(User user) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/users'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(user.toJson()),
      );
      switch (response.statusCode) {
        case 200:
          return;
        default:
          debugPrint(response.statusCode.toString());
          //debugPrint(response.body);
          //debugPrint(json.encode(user.toJson()));
          throw Exception('Failed to create user');
      }
    } catch (error) {
      debugPrint('Error creating user : $error');
      rethrow;
    }
  }

  //login user
  static Future<User> loginUser(String email, String password) async {
    try {
      final body = {
        "email": email,
        "password": password,
      };

      final response = await http.post(
        Uri.parse('http://localhost:3000/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      switch (response.statusCode) {
        case 200:
          final Map<String, dynamic>? userJson = json.decode(response.body) as Map<String, dynamic>?;
          if (userJson != null) {
            final user = User.fromJson(userJson['user']);
            return user;
          } else {
            throw Exception('Failed to decode user data');
          }
        default:
          debugPrint(response.statusCode.toString());
          debugPrint(json.encode(body));
          throw Exception('Failed to login user');
      }
    } catch (error) {
      debugPrint('Error login user : $error');
      debugPrint(email + password);
      rethrow;
    }
  }

}
