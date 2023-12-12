import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sorotangame/pages/categories_filtered.dart';

class CategoriesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 150,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            buildCategory('⚽', 'Olahraga', Color(0xffc1aebe), context),
            buildCategory('🕹', 'Laga', Color(0xffc1aebe), context),
            buildCategory('😌', 'Santai', Color(0xffc1aebe), context),
            buildCategory('🏫', 'Pendidikan', Color(0xffc1aebe), context),
          ],
        ),
      ),
    );
  }

  Widget buildCategory(String emoji, String categoryTitle, Color categoryColor,
      BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CategoriesPageFilter(selectedCategory: categoryTitle),
          ),
        );
      },
      child: Container(
        width: 150,
        height: 90,
        margin: EdgeInsets.symmetric(horizontal: 7),
        decoration: BoxDecoration(
          color: categoryColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40, // Ukuran Container untuk emoji
              height: 40, // Ukuran Container untuk emoji
              decoration: BoxDecoration(
                shape: BoxShape.circle, // Menambahkan bentuk lingkaran
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  emoji,
                  style: GoogleFonts.bubblegumSans(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              categoryTitle,
              style: GoogleFonts.bubblegumSans(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
