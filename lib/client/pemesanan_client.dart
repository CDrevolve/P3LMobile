import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:p3lmobile/model/pemesanan.dart';

class PemesananClient {
  static final String baseUrl = 'http://10.0.2.2:8000'; 
  static final String endpoint = 'api/pesanannMobile'; 

  // Fetch all orders for the authenticated user
  static Future<List<Pemesanan>> fetchAll(String token) async {
    try {
      var response = await http.get(
        Uri.parse('$baseUrl/$endpoint'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      // Print the status code and response body
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      // Check if the response is JSON
      if (!isJson(response.body)) {
        throw Exception('Invalid JSON response');
      }

      // Check if the response contains the expected key
      if (!json.decode(response.body).containsKey('pemesanan')) {
        throw Exception('Response does not contain expected key');
      }

      Iterable list = json.decode(response.body)['pemesanan'];
      return list.map((e) => Pemesanan.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Failed to fetch orders: $e');
    }
  }

  // Update the status of an order
  static Future<Pemesanan?> updateStatus(int id, String token) async {
    try {
      var response = await http.put(
        Uri.parse('$baseUrl/$endpoint/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      // Print the status code and response body
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // Check if the response is JSON
        if (!isJson(response.body)) {
          throw Exception('Invalid JSON response');
        }

        // Check if the response contains the expected key
        if (!json.decode(response.body).containsKey('pemesanan')) {
          throw Exception('Response does not contain expected key');
        }

        return Pemesanan.fromJson(json.decode(response.body)['pemesanan']);
      } else {
        throw Exception('Failed to update status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update status: $e');
    }
  }

  // Helper method to check if a string is valid JSON
  static bool isJson(String str) {
    try {
      json.decode(str);
      return true;
    } catch (e) {
      return false;
    }
  }
}
