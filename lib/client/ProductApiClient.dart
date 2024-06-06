import 'package:flutter/material.dart';
import 'package:p3lmobile/api/api_produk.dart';

class ProductApiClient {
  final ProductApi _api = ProductApi();

  Future<List<Map<String, dynamic>>> fetchProducts() => _api.fetchProducts();
}
