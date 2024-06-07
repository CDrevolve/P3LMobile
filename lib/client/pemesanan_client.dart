// lib/client/pemesanan_client.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:p3lmobile/model/pemesanan.dart';

class PemesananClient {
  static final String baseUrl = '10.0.2.2:8000';
  static final String endpoint = '/api/pesananMobile';

  final http.Client client;

  PemesananClient(this.client);

  Future<List<Pemesanan>> fetchAll() async {
    try {
      var response = await client.get(Uri.http(baseUrl, endpoint), headers: {
        'Authorization': 'Bearer YOUR_API_TOKEN'
      });

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      List<dynamic> jsonArray = json.decode(response.body)['pemesanan'];
      return jsonArray.map((json) => Pemesanan.fromJson(json)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<void> updateStatus(int id) async {
    try {
      var response = await client.put(
        Uri.http(baseUrl, '$endpoint/$id'),
        headers: {
          'Authorization': 'Bearer YOUR_API_TOKEN',
          'Content-Type': 'application/json'
        },
        body: json.encode({'status': 'Selesai'}),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
