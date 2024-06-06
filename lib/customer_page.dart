import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:p3lmobile/client/ProductApiClient.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ProductApiClient _apiClient = ProductApiClient();
  late Future<List<Map<String, dynamic>>> _futureProducts;

  @override
  void initState() {
    super.initState();
    _futureProducts = _apiClient.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  title: Text(product['nama']),
                  subtitle: Text('Price: \$${product['harga'].toStringAsFixed(2)}'),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(product['foto']),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

// Main function
void main() {
  runApp(MaterialApp(
    home: ProductListScreen(),
  ));
}