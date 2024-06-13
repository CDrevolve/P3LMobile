// lib/services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:p3lmobile/models/bahan_baku.dart';

class ApiService {
  static const String _baseUrl = 'http://10.0.2.2:8000/api';

  Future<List<BahanBaku>> fetchBahanBaku() async {
    final response = await http.get(Uri.parse('$_baseUrl/stok-bahan-baku'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => BahanBaku.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
