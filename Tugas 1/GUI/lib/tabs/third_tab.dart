import 'package:flutter/material.dart';

class GanjilGenapPage extends StatefulWidget {
  const GanjilGenapPage({super.key});

  @override
  State<GanjilGenapPage> createState() => _GanjilGenapPageState();
}

class _GanjilGenapPageState extends State<GanjilGenapPage> {
  String input = '';
  String result = '';
  String errorMsg = '';

  void buttonPressed(String value) {
    setState(() {
      errorMsg = '';
      if (value == 'C') {
        input = '';
        result = '';
        errorMsg = '';
      } else if (value == '<x') {
        if (input.isNotEmpty) input = input.substring(0, input.length - 1);
      } else if (value == '=') {
        String digitsOnly = input.replaceAll(RegExp(r'[^0-9]'), '');
        if (digitsOnly.length > 15) {
          errorMsg = 'Input maksimal 15 angka';
          result = '';
          return;
        }
        if (digitsOnly.isEmpty) {
          errorMsg = 'Input hanya boleh angka';
          result = '';
          return;
        }
        result = _checkOddEven(input);
      } else {
        String nextInput = input + value;
        String digitsOnly = nextInput.replaceAll(RegExp(r'[^0-9]'), '');
        if (digitsOnly.length > 15) {
          errorMsg = 'Input maksimal 15 angka';
          return;
        }
        input = nextInput;
      }
    });
  }

  String _checkOddEven(String text) {
    // Pisahkan input per baris, cek tiap baris
    List<String> lines = text
        .split(RegExp(r'\n|\r| '))
        .where((e) => e.trim().isNotEmpty)
        .toList();
    if (lines.isEmpty) return '';
    String last = lines.last;
    int? num = int.tryParse(last);
    if (num == null) return '';
    return num % 2 == 0 ? 'Even' : 'Odd';
  }

  final Color warnaOperator = Color.fromRGBO(126, 170, 101, 1);
  final Color warnaAngka = Color.fromRGBO(206, 185, 172, 1);

  Widget tombol(Widget label, Color warna, {int flex = 1, String? value}) {
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
          onPressed: () => buttonPressed(
            value ?? (label is Text ? (label as Text).data ?? '' : ''),
          ),
          child: label,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5DED9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: warnaOperator,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/bima.png',
                          width: 32,
                          height: 32,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
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
                        child: TextField(
                          minLines: 4,
                          maxLines: 6,
                          controller: TextEditingController(text: input),
                          onChanged: (val) {
                            setState(() {
                              String digitsOnly = val.replaceAll(
                                RegExp(r'[^0-9]'),
                                '',
                              );
                              if (digitsOnly.length > 15) {
                                errorMsg = 'Input maksimal 15 angka';
                              } else if (digitsOnly.isEmpty && val.isNotEmpty) {
                                errorMsg = 'Input hanya boleh angka';
                              } else {
                                errorMsg = '';
                                input = val;
                              }
                            });
                          },
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Masukkan angka...',
                          ),
                        ),
                      ),
                      if (errorMsg.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            errorMsg,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          result,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Grid tombol kiri
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                tombol(
                                  Text(
                                    'C',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  warnaOperator,
                                  value: 'C',
                                ),
                                tombol(
                                  Icon(
                                    Icons.text_decrease_rounded,
                                    size: 24,
                                    color: Colors.black,
                                  ),
                                  warnaOperator,
                                  value: '<x',
                                ),
                                tombol(
                                  Text(
                                    '(-)',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  warnaOperator,
                                  value: '(-)',
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                tombol(
                                  Text(
                                    '7',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  warnaAngka,
                                  value: '7',
                                ),
                                tombol(
                                  Text(
                                    '8',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  warnaAngka,
                                  value: '8',
                                ),
                                tombol(
                                  Text(
                                    '9',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  warnaAngka,
                                  value: '9',
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                tombol(
                                  Text(
                                    '4',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  warnaAngka,
                                  value: '4',
                                ),
                                tombol(
                                  Text(
                                    '5',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  warnaAngka,
                                  value: '5',
                                ),
                                tombol(
                                  Text(
                                    '6',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  warnaAngka,
                                  value: '6',
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                tombol(
                                  Text(
                                    '1',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  warnaAngka,
                                  value: '1',
                                ),
                                tombol(
                                  Text(
                                    '2',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  warnaAngka,
                                  value: '2',
                                ),
                                tombol(
                                  Text(
                                    '3',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  warnaAngka,
                                  value: '3',
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                tombol(
                                  Text(
                                    '0',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  warnaAngka,
                                  flex: 3,
                                  value: '0',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 230,
                          child: tombol(
                            Text(
                              '=',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            warnaOperator,
                            flex: 1,
                            value: '=',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
