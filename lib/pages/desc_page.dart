import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DescPage extends StatelessWidget {
  const DescPage({
    Key? key,
    required this.avatar,
    required this.name,
    required this.genre,
    required this.rating,
    required this.desk,
    required this.imageUrl1,
    required this.imageUrl2,
    required this.imageUrl3,
  }) : super(key: key);

  final String avatar,
      name,
      genre,
      rating,
      desk,
      imageUrl1,
      imageUrl2,
      imageUrl3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Game",
          style: GoogleFonts.bubblegumSans(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xffc1aebe),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Color(0xFFEFEFEF), // Warna latar belakang
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  avatar,
                  width: 100,
                  height: 100,
                ),
                const SizedBox(width: 20.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.bubblegumSans(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        genre,
                        style: GoogleFonts.bubblegumSans(
                          fontSize: 18.0,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Icon(Icons.star, color: Colors.yellow),
                SizedBox(width: 4),
                Text(
                  rating,
                  style: GoogleFonts.bubblegumSans(
                    fontSize: 18.0,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Divider(
              // Pembatas
              color: Colors.grey,
              thickness: 1,
              height: 10,
            ),
            const SizedBox(height: 10.0),
            Text(
              desk,
              style: GoogleFonts.bubblegumSans(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Divider(
              // Pembatas
              color: Colors.grey,
              thickness: 1,
              height: 10,
            ),
            const SizedBox(height: 10.0),
            Container(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  String imageUrl;
                  if (index == 0) {
                    imageUrl = imageUrl1;
                  } else if (index == 1) {
                    imageUrl = imageUrl2;
                  } else {
                    imageUrl = imageUrl3;
                  }
                  return Padding(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Image.network(
                      imageUrl,
                      width: 300,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
