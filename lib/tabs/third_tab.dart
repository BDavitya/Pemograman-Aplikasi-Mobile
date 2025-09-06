import 'package:flutter/material.dart';

class GanjilGenapPage extends StatefulWidget {
  const GanjilGenapPage({super.key});

  @override
  State<GanjilGenapPage> createState() => StateGanjilGenapPage();
}

class StateGanjilGenapPage extends State<GanjilGenapPage> {
  TextEditingController angka = TextEditingController();
  String hasil = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cek Ganjil/Genap')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: angka, decoration: InputDecoration(labelText: 'Masukkan angka'), keyboardType: TextInputType.number),
            Padding(padding: EdgeInsetsGeometry.all(7.0)),
            ElevatedButton(onPressed: () {
              int n = int.tryParse(angka.text) ?? 0;
              setState(() { hasil = n % 2 == 0 ? 'Genap' : 'Ganjil'; });
            }, child: Text('Cek')),
            SizedBox(height: 16),
            Text(hasil),
          ],
        ),
      ),
    );
  }
}
