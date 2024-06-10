import 'package:flutter/material.dart';
import 'package:p3lmobile/client/karyawan_client.dart';
import 'package:p3lmobile/client/presensi_client.dart';
import 'package:p3lmobile/model/karyawan.dart';
import 'package:p3lmobile/model/presensi.dart';
import 'login_page.dart';
import 'package:p3lmobile/landing_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:p3lmobile/Customer/navbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var token = prefs.getString("token");
  runApp(MainApp(
    token: token,
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key, this.token}) : super(key: key);
  final String? token;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: token == null ? LandingPage() : BottomNavbarScreen(),
    );
  }
}
