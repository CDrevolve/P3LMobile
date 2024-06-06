import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:p3lmobile/models/user.dart';

class ForgetClient {
  static final String baseUrl =
      'http://10.0.2.2:8000'; // base url untuk emulator
  static final String endpoint = '/api/fetchAll'; // base endpoint
  static final String endpointEmail =
      'api/forgetPasswordMobile/sendEmail'; // base endpoint

  static Future<List<User>> fetchAll() async {
    try {
      var response = await http.get(Uri.parse('$baseUrl/$endpoint'));
      if (response.statusCode != 200) throw Exception(response.body);

      Iterable list = json.decode(response.body)['user'];
      return list.map((e) => User.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future emailVerif(String email) async {
    print(Uri.parse('$baseUrl/$endpointEmail'));
    try {
      var response = await http.post(
        Uri.parse('$baseUrl/$endpointEmail'),
        body: {'email': email},
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData != null && responseData['message'] != null) {
          print('Email sent');
        } else {
          throw Exception('Invalid response data');
        }
      } else {
        throw Exception('Failed to send email: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to send email: $e');
    }
  }
}
