import 'package:flutter/material.dart';

class KalkulatorPage extends StatefulWidget {
  const KalkulatorPage({super.key});

  @override
  State<KalkulatorPage> createState() => _KalkulatorPageState();
}

class _KalkulatorPageState extends State<KalkulatorPage> {
  String input = '';
  String result = '';

  void buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        input = '';
        result = '';
      } else if (value == '<x') {
        if (input.isNotEmpty) input = input.substring(0, input.length - 1);
      } else if (value == '=') {
        // Validasi: tidak boleh diakhiri operator
        if (input.isEmpty || RegExp(r'[+\-*/.,]$').hasMatch(input)) {
          result = '';
          return;
        }
        try {
          String evalResult = _evaluate(input);
          if (evalResult.contains('e')) {
            result = '';
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text('Error'),
                content: Text('Hasil terlalu besar, tidak dapat ditampilkan.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: Text('OK'),
                  ),
                ],
              ),
            );
          } else {
            result = evalResult;
          }
        } catch (e) {
          result = 'Error';
        }
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

  String _evaluate(String expr) {
    expr = expr.replaceAll('×', '*').replaceAll('÷', '/').replaceAll(',', '.');
    try {
      if (expr.isEmpty) return '0';
      final exp = expr.replaceAll(RegExp(r'[^0-9+\-*/\.\-]'), '');
      // Cek pembagian 0
      if (RegExp(r'/0(?![0-9])').hasMatch(exp)) {
        return 'undefined';
      }
      double hasil = _simpleEval(exp);
      String hasilStr = hasil.toString();
      // Izinkan notasi e
      return hasilStr.replaceAll('.', ',');
    } catch (e) {
      return 'Error';
    }
  }

  double _simpleEval(String expr) {
    // Tokenize numbers and operators
    final numberReg = RegExp(r'-?\d+(?:\.\d+)?');
    final operatorReg = RegExp(r'[+\-*/]');
    List<double> numbers = [];
    List<String> operators = [];
    int i = 0;
    while (i < expr.length) {
      // Find number
      final numMatch = numberReg.matchAsPrefix(expr, i);
      if (numMatch != null) {
        numbers.add(double.parse(numMatch.group(0)!));
        i += numMatch.group(0)!.length;
      }
      // Find operator
      if (i < expr.length) {
        final opMatch = operatorReg.matchAsPrefix(expr, i);
        if (opMatch != null) {
          operators.add(opMatch.group(0)!);
          i += 1;
        }
      }
    }

    // First pass: handle * and /
    int idx = 0;
    while (idx < operators.length) {
      if (operators[idx] == '*' || operators[idx] == '/') {
        double left = numbers[idx];
        double right = numbers[idx + 1];
        double res = operators[idx] == '*' ? left * right : left / right;
        numbers[idx] = res;
        numbers.removeAt(idx + 1);
        operators.removeAt(idx);
      } else {
        idx++;
      }
    }
    // Second pass: handle + and -
    double total = numbers.isNotEmpty ? numbers[0] : 0;
    for (int j = 0; j < operators.length; j++) {
      if (operators[j] == '+') {
        total += numbers[j + 1];
      } else if (operators[j] == '-') {
        total -= numbers[j + 1];
      }
    }
    return total;
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12, left: 16, right: 16),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: double.infinity,
                    constraints: BoxConstraints(minHeight: 120, maxHeight: 250),
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
                            minLines: 2,
                            maxLines: 4,
                            controller: TextEditingController(text: input),
                            onChanged: (val) {
                              setState(() {
                                String digitsOnly = val.replaceAll(
                                  RegExp(r'[^0-9]'),
                                  '',
                                );
                                if (digitsOnly.length > 15) {
                                  input = digitsOnly.substring(0, 15);
                                } else {
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
                              hintText: 'Masukkan angka... (max 15 digit)',
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            constraints: BoxConstraints(maxWidth: 320),
                            child: Column(
                              children: [
                                Text(
                                  "Hasil:",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                  ),
                                ),
                                Text(
                                  result,
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
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
                      mainAxisAlignment: MainAxisAlignment.center,
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
                                '%',
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              warnaOperator,
                              value: '%',
                            ),
                            tombol(
                              Text(
                                '÷',
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              warnaOperator,
                              value: '÷',
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
                            tombol(
                              Text(
                                '×',
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              warnaOperator,
                              value: '×',
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
                            tombol(
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              warnaOperator,
                              value: '-',
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
                            tombol(
                              Text(
                                '+',
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              warnaOperator,
                              value: '+',
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
                              flex: 2,
                              value: '0',
                            ),
                            tombol(
                              Text(
                                ',',
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              warnaAngka,
                              value: ',',
                            ),
                            tombol(
                              Text(
                                '=',
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              warnaOperator,
                              value: '=',
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
    );
  }
}
