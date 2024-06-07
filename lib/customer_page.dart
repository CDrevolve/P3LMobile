import 'package:flutter/material.dart';
import 'package:p3lmobile/StatusPesananScreen.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StatusPesananScreen()),
            );
          },
          child: Text('Go to Status Pesanan'),
        ),
      ),
    );
  }
}


