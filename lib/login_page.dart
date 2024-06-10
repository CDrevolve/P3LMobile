import 'package:flutter/material.dart';
import 'package:p3lmobile/api/api.dart';
import 'package:p3lmobile/models/customer.dart';
import 'package:p3lmobile/Customer/navbar.dart';
import 'package:p3lmobile/presensi_page.dart';
import 'package:p3lmobile/customer_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late SharedPreferences _prefs;
  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> _saveLoginStatus(String? token) async {
    await _prefs.setString('token', token!);
  }

  bool _isLoading = false;
  String _errorMessage = '';

  void _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      final user = await UserClient.login(email, password);
      await _saveLoginStatus(user?.token);

      if (user != null) {
        switch (user.idRole) {
          case 3:
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => PresensiPage()));
            print(
                'Login successful as ${user.username}. Navigating to PresensiPage.');
            break;
          case 5:
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => BottomNavbarScreen()));
            print(
                'Login successful as ${user.username}. Navigating to PresensiPage.');
            break;
          default:
            print(
                'Login successful as ${user.username}. Navigating to default page.');
            break;
        }
      } else {
        setState(() {
          _errorMessage = 'Login failed. Invalid email or password.';
        });
      }
    } on Exception catch (e) {
      setState(() {
        _errorMessage = 'Login failed. ${e.toString()}';
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Login failed. ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _logout() {
    // Lakukan logika logout di sini
    // Contoh: Hapus token, reset state, dan navigasi ke halaman login
    // Misalnya:
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
    print('Logout successful');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ATMA'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _login,
                    child: Text('Login'),
                  ),
            SizedBox(height: 8.0),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
