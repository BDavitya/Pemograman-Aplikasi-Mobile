import 'package:flutter/material.dart';

class FirstTab extends StatelessWidget {
  const FirstTab({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Data Kelompok')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Kelompok xx:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('1. Barita'),
            Text('2. Bima'),
            Text('3. Rahman'),
          ],
        ),
      ),
    );
  }
}