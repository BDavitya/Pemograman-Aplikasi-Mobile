import 'dart:io';

class User {
  String username;
  String password;

  User(this.username, this.password);

  bool login(String inputUser, String inputPass) {
    return username == inputUser && password == inputPass;
  }
}

class Kelompok {
  String nama;
  List<String> anggota;

  Kelompok(this.nama, this.anggota);

  void tampilkan() {
    print("=== Data Kelompok: $nama ===");
    for (var i = 0; i < anggota.length; i++) {
      print("${i + 1}. ${anggota[i]}");
    }
  }
}

class Kalkulator {
  double tambah(double a, double b) => a + b;
  double kurang(double a, double b) => a - b;
  double kali(double a, double b) => a * b;
  double bagi(double a, double b) => b != 0 ? a / b : double.nan;
}

void cekGanjilGenap(int angka) {
  if (angka % 2 == 0) {
    print("$angka adalah bilangan GENAP");
  } else {
    print("$angka adalah bilangan GANJIL");
  }
}

void jumlahkanTotal(List<int> angka) {
  int total = angka.reduce((a, b) => a + b);
  print("Total jumlah angka = $total");
}

void main() {
  // Buat akun user
  var user = User("admin", "123");

  print("=== LOGIN ===");
  stdout.write("Username: ");
  String? username = stdin.readLineSync();
  stdout.write("Password: ");
  String? password = stdin.readLineSync();

  if (!user.login(username ?? "", password ?? "")) {
    print("Login gagal! Keluar program.");
    return;
  }

  print("Login berhasil! Selamat datang, $username\n");

  // Data kelompok
  var kelompok = Kelompok("Kelas SI-D", [
    "Barita Davitya Setiawati",
    "Muhammad Aditya Rahman",
    "Alif Bima Mahendra",
  ]);

  while (true) {
    print("\n=== MENU ===");
    print("1. Lihat Data Kelompok");
    print("2. Penjumlahan & Pengurangan");
    print("3. Perkalian & Pembagian");
    print("4. Cek Bilangan Ganjil/Genap");
    print("5. Jumlahkan Total Angka");
    print("0. Keluar");
    stdout.write("Pilih menu: ");
    String? pilihan = stdin.readLineSync();

    if (pilihan == "1") {
      kelompok.tampilkan();
    } else if (pilihan == "2") {
      var kalkulator = Kalkulator();
      stdout.write("Masukkan angka pertama: ");
      double a = double.parse(stdin.readLineSync()!);
      stdout.write("Masukkan angka kedua: ");
      double b = double.parse(stdin.readLineSync()!);
      print("Hasil Penjumlahan: ${kalkulator.tambah(a, b)}");
      print("Hasil Pengurangan: ${kalkulator.kurang(a, b)}");
    } else if (pilihan == "3") {
      var kalkulator = Kalkulator();
      stdout.write("Masukkan angka pertama: ");
      double a = double.parse(stdin.readLineSync()!);
      stdout.write("Masukkan angka kedua: ");
      double b = double.parse(stdin.readLineSync()!);
      print("Hasil Perkalian: ${kalkulator.kali(a, b)}");
      print("Hasil Pembagian: ${kalkulator.bagi(a, b)}");
    } else if (pilihan == "4") {
      stdout.write("Masukkan angka: ");
      int angka = int.parse(stdin.readLineSync()!);
      cekGanjilGenap(angka);
    } else if (pilihan == "5") {
      stdout.write("Masukkan angka dipisahkan spasi: ");
      List<String> input = stdin.readLineSync()!.split(" ");
      List<int> angka = input.map((e) => int.parse(e)).toList();
      jumlahkanTotal(angka);
    } else if (pilihan == "0") {
      print("Keluar program. Terima kasih!");
      break;
    } else {
      print("Pilihan tidak valid!");
    }
  }
}
