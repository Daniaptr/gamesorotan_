import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Icon(
            Icons.sort,
            size: 30,
            color: Color(0xffc1aebe),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20,
            ),
            child: Text(
              "GameSpotlight 🎮",
              style: GoogleFonts.bubblegumSans(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Color(0xffc1aebe),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
