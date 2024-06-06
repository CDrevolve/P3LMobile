import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductApi {
  final String baseUrl = 'http://10.0.2.2:8000/api/produk'; // Ganti dengan URL API produk Anda

  Future<List<Map<String, dynamic>>> fetchProducts() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
