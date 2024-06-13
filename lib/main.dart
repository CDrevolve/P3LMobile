import 'package:flutter/material.dart';
import 'package:p3lmobile/bahan_baku.dart';
import 'login_page.dart';
import 'customer_page.dart'; // Import halaman login yang telah dibuat sebelumnya
import 'package:p3lmobile/client/karyawan_client.dart';
import 'package:p3lmobile/client/presensi_client.dart';
import 'package:p3lmobile/model/karyawan.dart';
import 'package:p3lmobile/model/presensi.dart';
import 'login_page.dart'; 

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: LoginPage(),

    );
  }
}
