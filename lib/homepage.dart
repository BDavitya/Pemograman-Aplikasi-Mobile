// Mengimpor paket material Flutter untuk membangun UI.
import 'package:flutter/material.dart';
import 'package:flutter_application_1/tabs/first_tab.dart';
import 'package:flutter_application_1/tabs/second_tab.dart';
import 'package:flutter_application_1/tabs/third_tab.dart';
import 'package:flutter_application_1/tabs/fourth_tab.dart';

// import 'package:flutter_application_1/tabs/first_tab.dart';

// Kelas StatelessWidget untuk halaman login.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('T U G A S 1 P A M'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            // Widget TabBar untuk navigasi tab.
            const TabBar(
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.home, 
                    color: Colors.red,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.calculate, 
                    color: Colors.red,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.numbers, 
                    color: Colors.red,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.add, 
                    color: Colors.red,
                  ),
                ),
              ], 
            ),

            // Memperbaiki kesalahan dengan membungkus TabBarView dengan Expanded.
            // Ini membuat TabBarView mengambil semua ruang yang tersisa di dalam Column.
            const Expanded(
              child: TabBarView(
                children: [
                  // 1st tab
                  FirstTab(),

                  // 2nd tab
                  KalkulatorPage(),

                  // 3rd tab
                  GanjilGenapPage(),

                  //4th tab
                  JumlahTotalPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}