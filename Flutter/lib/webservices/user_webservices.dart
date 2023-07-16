import 'package:flutter/material.dart';
import 'package:goldie_studio/webservices/user_class.dart';
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
  static Future<void> deleteUser(int id) async {
    try {
      final response =
          await http.delete(Uri.parse('http://localhost:3000/users/$id'));
      switch (response.statusCode) {
        case 200:
          return;
        case 204:
          return;
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
}
