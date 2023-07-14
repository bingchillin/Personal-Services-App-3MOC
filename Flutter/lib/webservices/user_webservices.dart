import 'package:flutter/material.dart';
import 'package:goldie_studio/webservices/user_class.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserWebServices{
  static Future<List<User>> getAllUsers() async{
    try{
      final response = await http.get(Uri.parse('http://localhost:3000/users'));
      switch(response.statusCode){
        case 200:
          final List<dynamic> usersJson = json.decode(response.body) as List<dynamic>;

          return usersJson.map((userJson) {
            return User.fromJson(userJson as Map<String, dynamic>);
          }).toList();
        default:
          throw Exception('Failed to load users');
      }
    }catch(error){
      debugPrint('Error getting all users : $error');
      rethrow;
    }
  }
}