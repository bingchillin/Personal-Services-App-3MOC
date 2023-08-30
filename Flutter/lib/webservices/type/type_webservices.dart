import 'package:flutter/material.dart';
import 'package:goldie_studio/webservices/type/type_class.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TypesWebServices {
  //get all types
  static Future<List<Types>> getAllTypes() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/types'));
      switch (response.statusCode) {
        case 200:
          final List<dynamic> typesJson =
              json.decode(response.body) as List<dynamic>;

          return typesJson.map((typeJson) {
            return Types.fromJson(typeJson as Map<String, dynamic>);
          }).toList();
        default:
          throw Exception('Failed to load types');
      }
    } catch (error) {
      debugPrint('Error getting all types : $error');
      rethrow;
    }
  }

  // delete types
  static Future<bool> deleteTypes(int id) async {
    try {
      final response =
          await http.delete(Uri.parse('http://localhost:3000/types/$id'));
      switch (response.statusCode) {
        case 200:
          return true;
        case 204:
          return true;
        default:
          debugPrint(response.statusCode.toString());
          throw Exception('Failed to delete types');
      }
    } catch (error) {
      debugPrint('Error deleting types : $error');
      rethrow;
    }
  }

  // update types
  static Future<void> updateTypes(Types types) async {
    try {
      final response = await http.put(
        Uri.parse('http://localhost:3000/types/${types.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(types.toJson()),
      );
      switch (response.statusCode) {
        case 200:
          return;
        default:
          debugPrint(response.statusCode.toString());
          throw Exception('Failed to update types');
      }
    } catch (error) {
      debugPrint('Error updating types : $error');
      rethrow;
    }
  }

  // add types
  static Future<void> addTypes(Types types) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/types'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(types.toJson()),
      );
      switch (response.statusCode) {
        case 201:
          return;
        default:
          debugPrint(response.statusCode.toString());
          throw Exception('Failed to add types');
      }
    } catch (error) {
      debugPrint('Error adding types : $error');
      rethrow;
    }
  }
}