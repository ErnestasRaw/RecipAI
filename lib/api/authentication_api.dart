import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:receptai/globals.dart';
import 'package:receptai/helpers/logger_helper.dart';

class AuthenticationApi {
  AuthenticationApi._();

  static Future<http.Response> login(
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      return response;
    } catch (e) {
      xlog('ERROR: $e');
      rethrow;
    }
  }
}
