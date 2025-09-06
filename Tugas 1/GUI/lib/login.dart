// Mengimpor paket material Flutter untuk membangun UI.
import 'package:flutter/material.dart';
import 'homepage.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => StateLoginPage();
}

class StateLoginPage extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: username, decoration: InputDecoration(labelText: 'Username')),
            TextField(controller: password, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (username.text == 'user' && password.text == '123') {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));
                } else {
                  setState(() { error = 'Username atau password salah'; });
                }
              },
              child: Text('Login'),
            ),
            if (error.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(error, style: TextStyle(color: Colors.red)),
              ),
          ],
        ),
      ),
    );
  }
}
