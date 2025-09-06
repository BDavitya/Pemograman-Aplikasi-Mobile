// Mengimpor paket material Flutter untuk membangun UI.
// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'login.dart';

// Fungsi utama yang menjalankan aplikasi Flutter.
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      theme: ThemeData(primarySwatch: Colors.deepPurple),
    );
  }
}
