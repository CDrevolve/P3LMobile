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
      String token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNWY2ZDVmMTFiNDMwYjhmMDljYmUxZGE4YWFhNjRiNmY3OGM1MDlmYWU4ZTQ4ZjFjNmRhZjJmNDI2NzZlOGU0MTEwYmZlYWEzNjliMDRmOTMiLCJpYXQiOjE3MTc5MTg5NjIuNDA4NDQ0LCJuYmYiOjE3MTc5MTg5NjIuNDA4NDUzLCJleHAiOjE3NDk0NTQ5NjIuMzI5ODAxLCJzdWIiOiI0Iiwic2NvcGVzIjpbXX0.XDP4gITT6bEjDZmqdMG9uie-aIraBZDH56FO3CX1dsozO7yD9ZUVU1ol61xuPHec-yqgOPCPApPR2sZ2zvXPA_lffe5wU9NciUWMp39tdDHf-FgHV6_CL0zosTdq6Q4t0ISbiAMUtXqCS1d_1MsB7_Olp0QLqnQxhFnPUwz4inEr5JmexWHGcYSq-cwgYfmbTUz39gX87TQe8qOL7xwRRoj4VHmrhv1nDCoA196CrtGcJ6xJK6_viiM_TjiA_zcW7F0rGB2y3NXXbNiK7em--z6LMc9RhwT0eGzV2lRjQzrkw9DSCjhOME5OkDlkCss5U129DU_61yDajMkcPbhxethv2uOn3QC-O1EP_WBmRRzXRhsakzq9NyPakrCatKglLwu7gRhKaVxT6A3rLh90GMqP8CgLwzv0S1optvqk5ikj6Skz8N8JLk9NI2PLYDJ1vT2uuuyM2T8fk0fRpEBW1O5Zh8ou3ZtBCIwy531_TBdufOfq2DiI-TA6DRMir8J5EzKNB5PXzly814sUEDgBpIdLZjQpUYJ5B3O929XJwgm1oI7X6x1QeLOlGhWB__-ZVPfmbVyQ-7_MBTWSzcwHjrVrsWANcwzytI2UDbqPBpShAcsv5g2NYHbFtYVyMlw1eepC1zPXb-7Gj_TV2rCPJAhlDREMVWYAEAE7V1isl5w';
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

  Future<void> _updateOrderStatus(int orderId) async {
    try {
      String token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNWY2ZDVmMTFiNDMwYjhmMDljYmUxZGE4YWFhNjRiNmY3OGM1MDlmYWU4ZTQ4ZjFjNmRhZjJmNDI2NzZlOGU0MTEwYmZlYWEzNjliMDRmOTMiLCJpYXQiOjE3MTc5MTg5NjIuNDA4NDQ0LCJuYmYiOjE3MTc5MTg5NjIuNDA4NDUzLCJleHAiOjE3NDk0NTQ5NjIuMzI5ODAxLCJzdWIiOiI0Iiwic2NvcGVzIjpbXX0.XDP4gITT6bEjDZmqdMG9uie-aIraBZDH56FO3CX1dsozO7yD9ZUVU1ol61xuPHec-yqgOPCPApPR2sZ2zvXPA_lffe5wU9NciUWMp39tdDHf-FgHV6_CL0zosTdq6Q4t0ISbiAMUtXqCS1d_1MsB7_Olp0QLqnQxhFnPUwz4inEr5JmexWHGcYSq-cwgYfmbTUz39gX87TQe8qOL7xwRRoj4VHmrhv1nDCoA196CrtGcJ6xJK6_viiM_TjiA_zcW7F0rGB2y3NXXbNiK7em--z6LMc9RhwT0eGzV2lRjQzrkw9DSCjhOME5OkDlkCss5U129DU_61yDajMkcPbhxethv2uOn3QC-O1EP_WBmRRzXRhsakzq9NyPakrCatKglLwu7gRhKaVxT6A3rLh90GMqP8CgLwzv0S1optvqk5ikj6Skz8N8JLk9NI2PLYDJ1vT2uuuyM2T8fk0fRpEBW1O5Zh8ou3ZtBCIwy531_TBdufOfq2DiI-TA6DRMir8J5EzKNB5PXzly814sUEDgBpIdLZjQpUYJ5B3O929XJwgm1oI7X6x1QeLOlGhWB__-ZVPfmbVyQ-7_MBTWSzcwHjrVrsWANcwzytI2UDbqPBpShAcsv5g2NYHbFtYVyMlw1eepC1zPXb-7Gj_TV2rCPJAhlDREMVWYAEAE7V1isl5w';
      Pemesanan? updatedOrder = await PemesananClient.updateStatus(orderId, token);
      if (updatedOrder != null) {
        setState(() {
          _orders.removeWhere((order) => order.id_pemesanan == orderId);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Selamat Menikmati')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memperbarui status pesanan')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
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
                    return Card(
                      child: ListTile(
                        title: Text('${order.nama}'),
                        subtitle: Text('Status: ${order.status}'),
                        trailing: ElevatedButton(
                          onPressed: () {
                            _updateOrderStatus(order.id_pemesanan);
                          },
                          child: Text('Terima Pesanan'),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
