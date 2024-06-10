import 'package:flutter/material.dart';
import 'package:p3lmobile/Client/customer_client.dart';
import 'package:p3lmobile/Client/tariksaldo_client.dart';
import 'package:p3lmobile/model/tariksaldo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPenarikanScreen extends StatefulWidget {
  const HistoryPenarikanScreen({super.key});

  @override
  State<HistoryPenarikanScreen> createState() => _HistoryPenarikanScreenState();
}

class _HistoryPenarikanScreenState extends State<HistoryPenarikanScreen> {
  late SharedPreferences prefs;
  String token = '';
  List<TarikSaldo?> HistoryPenarikan = [];
  bool _isLoading = true;

  Future<void> refresh() async {
    try {
      final HistoryPenarikanScreen = await TarikSaldoClient.fetchAll(token);

      setState(() {
        HistoryPenarikan = HistoryPenarikanScreen;
      });
    } catch (e) {
      print('Failed to get History: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token')!;
      _isLoading = true;
    });
    refresh();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History Penarikan'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: HistoryPenarikan.length,
              itemBuilder: (context, index) {
                final item = HistoryPenarikan[index];
                return ListTile(
                  title: Text('${index+1}. Bank: ${item!.bank} - Saldo: ${item.saldo}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('No Rekening: ${item.noRekening}'),
                      Text('Status: ${item.status}'),
                      Text('Tanggal: ${item.tanggal}'),
                    ],
                  ),
                  isThreeLine: true,
                );
              },
            ),
    );
  }
}
