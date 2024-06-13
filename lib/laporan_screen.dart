import 'package:flutter/material.dart';
import 'package:p3lmobile/client/laporan_client';

class LaporanScreen extends StatelessWidget {
  final LaporanClient apiService = LaporanClient();
  final int tahun;

  LaporanScreen({required this.tahun});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Laporan Penjualan Tahunan')),
      body: FutureBuilder(
        future: apiService.fetchPenjualanTahunan(tahun),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<dynamic> data = snapshot.data as List<dynamic>;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Bulan: ${data[index]['bulan']}'),
                  subtitle: Text('Total Uang: ${data[index]['total_uang']}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
