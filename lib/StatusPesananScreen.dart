import 'package:flutter/material.dart';
import 'package:p3lmobile/client/pemesanan_client.dart';
import 'package:p3lmobile/model/pemesanan.dart';

class StatusPesananScreen extends StatefulWidget {
  @override
  _StatusPesananScreenState createState() => _StatusPesananScreenState();
}

class _StatusPesananScreenState extends State<StatusPesananScreen> {
  List<Pemesanan> _orders = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    try {
      // Assuming you have the token stored somewhere
      String token = 'your_auth_token_here';
      List<Pemesanan> orders = await PemesananClient.fetchAll(token);
      setState(() {
        _orders = orders;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Status Pesanan'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(child: Text('Error: $_errorMessage'))
              : ListView.builder(
                  itemCount: _orders.length,
                  itemBuilder: (context, index) {
                    Pemesanan order = _orders[index];
                    return ListTile(
                      title: Text('Order ID: ${order.id_pemesanan}'),
                      subtitle: Text('Status: ${order.status}'),
                    );
                  },
                ),
    );
  }
}
