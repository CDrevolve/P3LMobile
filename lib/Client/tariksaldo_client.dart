import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:p3lmobile/model/tariksaldo.dart';
import 'package:p3lmobile/models/user.dart';

class TarikSaldoClient {
  static final String baseUrl = '10.0.2.2:8000'; // base url untuk emulator
  static final String endpoint = 'api/ajuanSaldoMobile'; // base endpoint
  // base endpoint

  static Future<List<TarikSaldo>> fetchAll(String token) async {
    try {
      var response = await http.get(
        Uri.http(baseUrl, endpoint),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode != 200) throw Exception(response.body);

      Iterable list = json.decode(response.body)['data'];
      return list.map((e) => TarikSaldo.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<bool?> find(String token, String Rekening, String Bank) async {
    try {
      print(Uri.http(baseUrl, endpoint));
      var response = await http.post(Uri.http(baseUrl, endpoint),
          headers: {'Authorization': 'Bearer $token'},
          body: {'no_rekening': Rekening, 'bank': Bank});

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      print(response.body);

      // return Customer.fromJson(json.decode(response.body)['data']);
      return true;
    } catch (e) {
      print("Error: $e");
      throw Exception(e.toString());
    }
  }
}
