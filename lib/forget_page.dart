import 'package:flutter/material.dart';
import 'package:p3lmobile/Client/forget_passClient.dart';

class forgetPage extends StatefulWidget {
  const forgetPage({super.key});

  @override
  State<forgetPage> createState() => _forgetPageState();
}

class _forgetPageState extends State<forgetPage> {
  final TextEditingController _emailController = TextEditingController();

  Future<void> _emailVerif(String email) async {
    try {
      // Call the emailVerif method from the ForgetClient class
      // For example:
      // await ForgetClient.emailVerif(_emailController.text);

      await ForgetClient.emailVerif(email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email Sent!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send email: $e')),
      );

      print('Failed to send email: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forget Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Call the emailVerif method from the ForgetClient class
                // For example:
                // await ForgetClient.emailVerif(_emailController.text);
                await _emailVerif(_emailController.text);
              },
              child: Text('Send Email'),
            ),
          ],
        ),
      ),
    );
  }
}
