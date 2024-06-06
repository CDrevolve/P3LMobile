import 'package:flutter/material.dart';
import 'package:p3lmobile/landing_page.dart';
import 'login_page.dart'; // Import halaman login yang telah dibuat sebelumnya

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LandingPage(), // Mengatur halaman login sebagai halaman utama
    );
  }
}
