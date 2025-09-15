import 'package:flutter/material.dart';

class JumlahTotalPage extends StatefulWidget {
  const JumlahTotalPage({super.key});

  @override
  State<JumlahTotalPage> createState() => StateJumlahTotalPage();
}

class StateJumlahTotalPage extends State<JumlahTotalPage> {
  // String TextEditingController input = TextEditingController();
  String input = '';
  String panjang = '';
  String result = '';
  //12345

  final Color warnaOperator = Color.fromRGBO(126, 170, 101, 1);
  final Color warnaAngka = Color.fromRGBO(206, 185, 172, 1);

  Widget tombol(String label, Color warna, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Container(
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: warna,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: TextButton(
          onPressed: () => buttonPressed(label),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  void buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        input = '';
        panjang = '';
      } else if (value == '<x') {
        if (input.isNotEmpty) input = input.substring(0, input.length - 1);
      } else if (value == '=') {
        panjang = "${input.length.toString()} Digit";
      } else {
        // Izinkan minus di awal
        if (input.isEmpty && value == '-') {
          input += value;
        } else {
          input += value;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5DED9),
      body: Padding(
        padding: EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // ini sementara dari kiri
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [],
              ),
            ),
            Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              input,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            panjang,
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        tombol('7', warnaAngka),
                                        tombol('8', warnaAngka),
                                        tombol('9', warnaAngka),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        tombol('4', warnaAngka),
                                        tombol('5', warnaAngka),
                                        tombol('6', warnaAngka),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        tombol('1', warnaAngka),
                                        tombol('2', warnaAngka),
                                        tombol('3', warnaAngka),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        tombol('<x', warnaOperator),
                                        tombol('0', warnaAngka),
                                        tombol('=', warnaOperator),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    tombol('C', warnaOperator);
                                  },
                                  child: Container(
                                    height: 250,
                                    child: tombol('C', warnaOperator),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
