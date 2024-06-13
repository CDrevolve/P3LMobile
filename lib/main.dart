import 'package:flutter/material.dart';
import 'package:p3lmobile/bahan_baku.dart';
import 'login_page.dart';
import 'customer_page.dart'; // Import halaman login yang telah dibuat sebelumnya

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  BahanBakuScreen() // Mengatur halaman login sebagai halaman utama
    );
  }
}
