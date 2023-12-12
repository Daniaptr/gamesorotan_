import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SavedItemPage extends StatelessWidget {
  const SavedItemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Item'),
      ),
      backgroundColor: Color(0xffc1aebe),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              'Your Saved Items',
              style: GoogleFonts.bubblegumSans(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Expanded(
              // Wrap ListView.builder with a Flexible widget
              child: Flexible(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text('Item ${index + 1}'),
                        subtitle: Text('Description of Item ${index + 1}'),
                        trailing: Icon(Icons.favorite, color: Colors.red),
                        onTap: () {
                          // Action when the item is tapped
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
