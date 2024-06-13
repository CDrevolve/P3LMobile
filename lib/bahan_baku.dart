

import 'package:flutter/material.dart';
import 'package:p3lmobile/api/api_bahanbaku.dart';
import 'package:p3lmobile/models/bahan_baku.dart';

class BahanBakuScreen extends StatefulWidget {
  @override
  _BahanBakuScreenState createState() => _BahanBakuScreenState();
}

class _BahanBakuScreenState extends State<BahanBakuScreen> {
  late Future<List<BahanBaku>> futureBahanBaku;

  @override
  void initState() {
    super.initState();
    futureBahanBaku = ApiService().fetchBahanBaku();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stok Bahan Baku'),
      ),
      body: FutureBuilder<List<BahanBaku>>(
        future: futureBahanBaku,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                BahanBaku bahanBaku = snapshot.data![index];
                return ListTile(
                  title: Text(bahanBaku.nama),
                  subtitle: Text('Satuan: ${bahanBaku.satuan}, Stok: ${bahanBaku.stok}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
