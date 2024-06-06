import 'package:flutter/material.dart';

import 'package:p3lmobile/client/karyawan_client.dart';
import 'package:p3lmobile/client/presensi_client.dart';
import 'package:p3lmobile/model/karyawan.dart';
import 'package:p3lmobile/model/presensi.dart';
import 'login_page.dart'; 

void main() {
  runApp(PresensiApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}
