import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sorotangame/pages/login_page.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/GetStarted.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Content
            Positioned(
              bottom: 100, // Letakkan tombol di paling bawah
              left: 20,
              right: 20,
              child: Column(
                children: [
                  Text(
                    'GAME SPOTLIGHT',
                    style: GoogleFonts.bubblegumSans(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Jelajahi Dunia Game Bersama GameSpotlight',
                    style: GoogleFonts.bubblegumSans(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Pindah ke halaman kedua saat tombol ditekan
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text('Get Started'),
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
