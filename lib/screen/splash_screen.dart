import 'package:flutter/material.dart';
import 'package:sorotangame/screen/welcome_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3)).then((value) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => WelcomeScreen()),
          (route) => false);
    });

    return Scaffold(
      backgroundColor: Color(0xffc1aebe), // Tambahkan warna latar belakang
      body: Center(
        child: Image.asset(
          "assets/images/logo.png",
          width: 150, // Ganti ukuran gambar sesuai kebutuhan
          height: 150, // Ganti ukuran gambar sesuai kebutuhan
        ),
      ),
    );
  }
}
