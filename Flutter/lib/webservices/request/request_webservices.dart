import 'package:flutter/material.dart';
import 'package:goldie_studio/webservices/request/request_class.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RequestWebServices {
  static Future<List<Request>> getAllRequests() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:3000/requetes'));
      switch (response.statusCode) {
        case 200:
          final List<dynamic> requetesJson =
              json.decode(response.body) as List<dynamic>;

          return requetesJson.map((requestJson) {
            return Request.fromJson(requestJson as Map<String, dynamic>);
          }).toList();
        default:
          throw Exception('Failed to load requetes');
      }
    } catch (error) {
      debugPrint('Error getting all requetes : $error');
      rethrow;
    }
  }

  // delete request
  static Future<void> deleteRequest(int id) async {
    try {
      final response =
          await http.delete(Uri.parse('http://localhost:3000/requetes/$id'));
      switch (response.statusCode) {
        case 200:
          return;
        case 204:
          return;
        default:
          debugPrint(response.statusCode.toString());
          throw Exception('Failed to delete request');
      }
    } catch (error) {
      debugPrint('Error deleting request : $error');
      rethrow;
    }
  }

  // update request
  static Future<void> updateRequest(Request request) async {
    try {
      final response = await http.put(
        Uri.parse('http://localhost:3000/requetes/${request.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(request.toJson()),
      );
      switch (response.statusCode) {
        case 200:
          return;
        default:
          debugPrint(response.statusCode.toString());
          throw Exception('Failed to update request');
      }
    } catch (error) {
      debugPrint('Error updating request : $error');
      rethrow;
    }
  }

  // create request

  static Future<void> createRequest(Request request) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/requetes'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(request.toJson()),
      );

      debugPrint(json.encode(request.toJson()));
      switch (response.statusCode) {
        case 200:
          return;
        default:
          //debugPrint(response.statusCode.toString());
          //debugPrint(response.body);
          throw Exception('Failed to create request');
      }
    } catch (error) {
      debugPrint('Error creating request : $error');
      rethrow;
    }
  }
}
