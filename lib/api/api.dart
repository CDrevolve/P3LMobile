import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:p3lmobile/models/user.dart';

class UserClient {
  static final String baseUrl = 'http://10.0.2.2:8000'; // base url untuk emulator
  static final String endpoint = 'api/loginMobile'; // base endpoint

  static Future<List<User>> fetchAll() async {
    try {
      var response = await http.get(Uri.parse('$baseUrl/$endpoint'));
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['user'];
      return list.map((e) => User.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<User?> login(String email, String password) async {
    try {
      var response = await http.post(
        Uri.parse('$baseUrl/$endpoint'),
        body: {'email': email, 'password': password},
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData != null && responseData['data'] != null) {
          final result = User.fromJson(json.decode(response.body)['data']);
          return result;
        } else {
          throw Exception('Invalid response data');
        }
      } else {
        throw Exception('Failed to login: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  static Future<User?> find(String email) async {
    try {
      var response = await http.get(Uri.parse('$baseUrl/$endpoint/$email'));
      if (response.statusCode != 200) return null;

      return User.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
