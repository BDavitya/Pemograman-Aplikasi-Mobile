import 'package:flutter/material.dart';

class KalkulatorPage extends StatefulWidget {
  const KalkulatorPage({super.key});

  @override
  State<KalkulatorPage> createState() => StateKalkulatorPage();
}

class StateKalkulatorPage extends State<KalkulatorPage> {
  TextEditingController a = TextEditingController();
  TextEditingController b = TextEditingController();
  String hasil = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kalkulator')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: a, decoration: InputDecoration(labelText: 'Angka 1'), keyboardType: TextInputType.number),
            TextField(controller: b, decoration: InputDecoration(labelText: 'Angka 2'), keyboardType: TextInputType.number),
            Padding(padding: EdgeInsetsGeometry.all(7.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: () {
                  double aa = double.tryParse(a.text) ?? 0;
                  double bb = double.tryParse(b.text) ?? 0;
                  setState(() { hasil = 'Hasil: ${aa + bb}'; });
                }, child: Text('+')),
                ElevatedButton(onPressed: () {
                  double aa = double.tryParse(a.text) ?? 0;
                  double bb = double.tryParse(b.text) ?? 0;
                  setState(() { hasil = 'Hasil: ${aa - bb}'; });
                }, child: Text('-')),
                ElevatedButton(onPressed: () {
                  double aa = double.tryParse(a.text) ?? 0;
                  double bb = double.tryParse(b.text) ?? 0;
                  setState(() { hasil = 'Hasil: ${aa * bb}'; });
                }, child: Text('x')),
                ElevatedButton(onPressed: () {
                  double aa = double.tryParse(a.text) ?? 0;
                  double bb = double.tryParse(b.text) ?? 0;
                  setState(() { hasil = bb != 0 ? 'Hasil: ${aa / bb}' : 'Tidak bisa dibagi nol'; });
                }, child: Text('/')),
              ],
            ),
            SizedBox(height: 16),
            Text(hasil),
          ],
        ),
      ),
    );
  }
}