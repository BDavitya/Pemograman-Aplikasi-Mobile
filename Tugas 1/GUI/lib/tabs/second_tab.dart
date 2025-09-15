import 'package:flutter/material.dart';

class KalkulatorPage extends StatefulWidget {
  const KalkulatorPage({super.key});

  @override
  State<KalkulatorPage> createState() => _KalkulatorPageState();
}

class _KalkulatorPageState extends State<KalkulatorPage> {
  int _selectedIndex = 1; // default ke kalkulator

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
          result = _evaluate(input);
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(126, 170, 101, 1),
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
                ),
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
                          result,
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            tombol('C', warnaOperator),
                            tombol('<x', warnaOperator),
                            tombol('%', warnaOperator),
                            tombol('÷', warnaOperator),
                          ],
                        ),
                        Row(
                          children: [
                            tombol('7', warnaAngka),
                            tombol('8', warnaAngka),
                            tombol('9', warnaAngka),
                            tombol('×', warnaOperator),
                          ],
                        ),
                        Row(
                          children: [
                            tombol('4', warnaAngka),
                            tombol('5', warnaAngka),
                            tombol('6', warnaAngka),
                            tombol('-', warnaOperator),
                          ],
                        ),
                        Row(
                          children: [
                            tombol('1', warnaAngka),
                            tombol('2', warnaAngka),
                            tombol('3', warnaAngka),
                            tombol('+', warnaOperator),
                          ],
                        ),
                        Row(
                          children: [
                            tombol('0', warnaAngka, flex: 2),
                            tombol(',', warnaAngka),
                            tombol('=', warnaOperator),
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
