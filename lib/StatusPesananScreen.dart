// lib/StatusPesananScreen.dart

import 'package:flutter/material.dart';
import 'package:p3lmobile/client/pemesanan_client.dart';
import 'package:p3lmobile/model/pemesanan.dart';
import 'package:http/http.dart' as http;

class StatusPesananScreen extends StatefulWidget {
  @override
  _StatusPesananScreenState createState() => _StatusPesananScreenState();
}

class _StatusPesananScreenState extends State<StatusPesananScreen> {
  final PemesananClient _client = PemesananClient(http.Client());
  late Future<List<Pemesanan>> _futurePemesanan;

  @override
  void initState() {
    super.initState();
    _futurePemesanan = _client.fetchAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Status Pesanan'),
      ),
      body: FutureBuilder<List<Pemesanan>>(
        future: _futurePemesanan,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final pemesananList = snapshot.data!;
            return ListView.builder(
              itemCount: pemesananList.length,
              itemBuilder: (context, index) {
                final pemesanan = pemesananList[index];
                return ListTile(
                  title: Text(pemesanan.nama),
                  subtitle: Text('Status: ${pemesanan.status}'),
                  trailing: pemesanan.status != 'Selesai'
                      ? ElevatedButton(
                          onPressed: () {
                            _client.updateStatus(pemesanan.id_pemesanan).then((_) {
                              setState(() {
                                _futurePemesanan = _client.fetchAll();
                              });
                            });
                          },
                          child: Text('Selesai'),
                        )
                      : null,
                );
              },
            );
          }
        },
      ),
    );
  }
}
