import 'package:flutter/material.dart';
import 'package:p3lmobile/Client/tariksaldo_client.dart';
import 'package:p3lmobile/Customer/HistoryPenarikan.dart';
import 'package:p3lmobile/landing_page.dart';
import 'package:p3lmobile/login_page.dart';
import 'package:p3lmobile/model/customer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:p3lmobile/Client/customer_client.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late SharedPreferences prefs;
  String token = '';
  Customer? customer;
  bool _isLoading = true;

  Future<void> refresh() async {
    try {
      final customer = await CustomerClient.find(token);
      print(customer!.nama);
      setState(() {
        this.customer = customer;
      });
    } catch (e) {
      print('Failed to get customer: $e');
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
        title: const Text('Profile'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                ),
                Center(
                  child: Text('Nama: ' + customer!.nama),
                ),
                Center(
                  child: Text('Tanggal Lahir: ' + customer!.tanggal_lahir),
                ),
                Center(
                  child: Text('No Telp:' + customer!.no_telp),
                ),
                Center(
                  child: Text('Saldo:' + customer!.saldo.toString()),
                ),
                Center(
                  child: Text('Poin:' + customer!.poin.toString()),
                ),
                if (customer!.saldo > 0)
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        _selesaiConfirmationDialog(context);
                      },
                      child: const Text('Tarik Saldo'),
                    ),
                  ),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HistoryPenarikanScreen(),
                        ),
                      );
                    },
                    child: const Text('History Penarikan Saldo'),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    onPressed: () async {
                      prefs.remove('token');
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LandingPage(),
                        ),
                        (route) => false,
                      );
                    },
                    child: const Text('Logout'),
                  ),
                )
              ],
            ),
    );
  }

  Future<void> _selesaiConfirmationDialog(BuildContext context) async {
    // TextEditingController _saldoController = TextEditingController();
    TextEditingController _BankController = TextEditingController();
    TextEditingController _RekeningController = TextEditingController();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tarik Saldo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Apakah anda yakin ingin menarik saldo?'),
              TextField(
                controller: _BankController,
                decoration: InputDecoration(
                  labelText: 'Bank',
                ),
              ),
              TextField(
                controller: _RekeningController,
                decoration: InputDecoration(
                  labelText: 'Rekening',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Tidak', style: TextStyle(color: Colors.green)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Ya', style: TextStyle(color: Colors.red)),
              onPressed: () async {
                // Call the selesaiPesanan method from the PemesananClient class
                // For example:
                // await PemesananClient.selesaiPesanan(order.id_pemesanan);
                // await _selesaiPesanan(order.id_pemesanan);
                await TarikSaldoClient.find(
                    token, _RekeningController.text, _BankController.text);
                Navigator.of(context).pop();
                refresh();
              },
            ),
          ],
        );
      },
    );
  }
}
