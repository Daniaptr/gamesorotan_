import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sorotangame/pages/login_page.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late User? _user;
  String name = "";
  String email = "";
  String phoneNumber = "";

  File? image;
  Future getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked =
        await picker.pickImage(source: ImageSource.gallery);
    if (imagePicked != null) {
      setState(() {
        image = File(imagePicked.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    if (_user != null) {
      try {
        DocumentSnapshot userSnapshot =
            await _firestore.collection("users").doc(_user!.uid).get();
        if (userSnapshot.exists) {
          setState(() {
            name = userSnapshot.get("name") ?? "";
            email = userSnapshot.get("email") ?? "";
            phoneNumber = userSnapshot.get("phoneNumber") ?? "";
          });
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  Future<void> _signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Konfirmasi Logout'),
                    content: Text('Apakah Anda yakin akan logout?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Batal'),
                      ),
                      TextButton(
                        onPressed: () {
                          _signOut().then((_) {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                              (Route<dynamic> route) => false,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Anda berhasil logout dari akun'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }).catchError((error) {
                            print('Error signing out: $error');
                          });
                        },
                        child: Text('Ya'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 243, 242, 242),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 80,
                    backgroundImage: image != null ? FileImage(image!) : null,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: EdgeInsets.all(8),
                    child: IconButton(
                      icon: Icon(Icons.camera_alt),
                      onPressed: () async {
                        await getImage();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ProfileTile(ikon: Icons.person, title: "Name", isi: name),
              ProfileTile(ikon: Icons.email, title: "Email", isi: email),
              ProfileTile(
                  ikon: Icons.phone, title: "phoneNumber", isi: phoneNumber),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileTile extends StatelessWidget {
  final IconData ikon;
  final String title;
  final String isi;
  const ProfileTile({
    Key? key,
    required this.ikon,
    required this.title,
    required this.isi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Container(
        width: 300,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          border: Border.all(
            color: Colors.black,
          ),
        ),
        child: Row(
          children: [
            Icon(
              ikon,
              color: Colors.black, // Mengubah warna ikon menjadi hitam
              size: 40,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black, // Mengubah warna teks menjadi hitam
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  isi,
                  style: TextStyle(
                    color: Colors.black, // Mengubah warna teks menjadi hitam
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
