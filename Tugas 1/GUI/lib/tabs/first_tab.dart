import 'package:flutter/material.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        DalamCard(
          pathGambar: 'assets/images/barita.png',
          studentId: '124230073',
          mainName: 'BARITA',
          subName: 'Davitya Setiawati',
        ),

        DalamCard(
          pathGambar: 'assets/images/rahman.png',
          studentId: '124230100',
          mainName: 'RAHMAN',
          subName: 'Muhammad Aditya',
        ),

        DalamCard(
          pathGambar: 'assets/images/bima.png',
          studentId: '124230121',
          mainName: 'BIMA',
          subName: 'Alif Mahendra',
        ),
        Image(
          image: AssetImage('img/7026a5f4328e68bf3f8438ee8d414baf6950e79e.png'),
        ),
      ],
    );
  }
}

class DalamCard extends StatelessWidget {
  final String studentId;
  final String pathGambar;
  final String mainName;
  final String subName;
  final Alignment nameAlignment;

  const DalamCard({
    super.key,
    required this.studentId,
    required this.pathGambar,
    required this.mainName,
    required this.subName,
    this.nameAlignment = Alignment.centerLeft, // Default alignment
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFD9E4D4),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: Colors.black, width: 2.5),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Layout utama (foto dan nama)
          Row(
            children: [
              // 1. Foto
              Container(
                width: 120,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(17),
                    bottomLeft: Radius.circular(17),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(17),
                    bottomLeft: Radius.circular(17),
                  ),
                  child: Image.asset(pathGambar, fit: BoxFit.cover),
                ),
              ),

              // 2. Nama
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        subName,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        mainName,
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          height: 1.2, // Mengatur jarak antar baris
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // 3. NIM
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFC7D3B8),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black54),
              ),
              child: Text(
                studentId,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
