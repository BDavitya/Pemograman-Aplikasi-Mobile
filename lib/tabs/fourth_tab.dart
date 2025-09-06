import 'package:flutter/material.dart';


class JumlahTotalPage extends StatefulWidget {
  const JumlahTotalPage ({super.key});

  @override
  State<JumlahTotalPage> createState() => StateJumlahTotalPage();
}

class StateJumlahTotalPage extends State<JumlahTotalPage> {
  TextEditingController angka = TextEditingController();
  String hasil = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Jumlah Total Angka')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: angka, decoration: InputDecoration(labelText: 'Masukkan angka, pisahkan dengan koma'), keyboardType: TextInputType.text),
            Padding(padding: EdgeInsetsGeometry.all(7.0)),
            ElevatedButton(onPressed: () {
              List<String> arr = angka.text.split(',');
              int total = 0;
              for (var s in arr) {
                total += int.tryParse(s.trim()) ?? 0;
              }
              setState(() { hasil = 'Jumlah total: $total'; });
            }, child: Text('Hitung Total')),
            SizedBox(height: 16),
            Text(hasil),
          ],
        ),
      ),
    );
  }
}