import 'package:flutter/material.dart';
import 'package:goldie_studio/webservices/request/request_class.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RequestWebServices {
  static Future<List<Request>> getAllRequests() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/requests'));
      switch (response.statusCode) {
        case 200:
          final List<dynamic> requestsJson =
              json.decode(response.body) as List<dynamic>;

          return requestsJson.map((requestJson) {
            return Request.fromJson(requestJson as Map<String, dynamic>);
          }).toList();
        default:
          throw Exception('Failed to load requests');
      }
    } catch (error) {
      debugPrint('Error getting all requests : $error');
      rethrow;
    }
  }

  // delete request
  static Future<void> deleteRequest(int id) async {
    try {
      final response =
          await http.delete(Uri.parse('http://localhost:3000/requests/$id'));
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
        Uri.parse('http://localhost:3000/requests/${request.id}'),
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
}