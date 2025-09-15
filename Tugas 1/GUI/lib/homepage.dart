import 'package:flutter/material.dart';
import 'package:flutter_application_1/tabs/first_tab.dart';
import 'package:flutter_application_1/tabs/fourth_tab.dart';
import 'package:flutter_application_1/tabs/second_tab.dart';
import 'package:flutter_application_1/tabs/third_tab.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Untuk melacak item navbar yang aktif

  // Placeholder untuk halaman-halaman yang akan kamu buat nanti
  static const List<Widget> _widgetOptions = <Widget>[
    Center(child: GroupPage()), //tinggal diganti nanti di tabs-tabs-nya
    Center(child: KalkulatorPage()), //tinggal diganti nanti di tabs-tabs-nya
    Center(child: JumlahTotalPage()), //tinggal diganti nanti di tabs-tabs-nya
    Center(child: GanjilGenapPage()), //tinggal diganti nanti di tabs-tabs-nya
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Navigasi ke route sesuai tab
    switch (index) {
      case 0:
        context.go('/first');
        break;
      case 1:
        context.go('/second');
        break;
      case 2:
        context.go('/fourth');
        break;
      case 3:
        context.go('/third');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 4. Konten Utama (akan berubah sesuai navbar)
              Expanded(child: _widgetOptions.elementAt(_selectedIndex)),
            ],
          ),
        ),
      ),

      //Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey[600],
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.group_outlined, ),
            activeIcon: Icon(Icons.group),
            label: 'Group',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate_outlined),
            activeIcon: Icon(Icons.calculate),
            label: 'Arithmetic',
          ),
          BottomNavigationBarItem(
            icon: Text('Σ', style: TextStyle(fontSize: 24, color: Colors.grey)),
            activeIcon: Text(
              'Σ',
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
            label: 'Sum of',
          ),
          BottomNavigationBarItem(
            icon: Text('%', style: TextStyle(fontSize: 24, color: Colors.grey)),
            activeIcon: Text(
              '%',
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
            label: 'Odd/Even',
          ),
        ],
      ),
    );
  }
}
