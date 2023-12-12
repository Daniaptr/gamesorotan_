import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:sorotangame/server/dbservice.dart';

CollectionReference tbDataGame = FirebaseFirestore.instance.collection("game");
CollectionReference tbUser = FirebaseFirestore.instance.collection("users");

class Database {
  //  ---------- METHOD TAMPIL SEMUA DATA ----------  //
  static Stream<QuerySnapshot> getData() {
    return tbDataGame.snapshots();
  }

  //  ---------- METHOD SEARCH DATAGAME ----------  //
  static Stream<QuerySnapshot> searchDataGame(String keyword) {
    if (keyword.isEmpty) {
      return tbDataGame.snapshots();
    } else {
      return tbDataGame
          .where('name', isGreaterThanOrEqualTo: keyword)
          .where('name', isLessThanOrEqualTo: keyword + '\uf8ff')
          .snapshots();
    }
  }

  //  ---------- METHOD USER ----------  //
  static Future<MyUser> getUser({required String email}) async {
    QuerySnapshot querySnapshot =
        await tbUser.where("email", isEqualTo: email).get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot docSnapshot = querySnapshot.docs.first;
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
      return MyUser.fromJson(data); // Sesuaikan dengan model data pengguna Anda
    } else {
      throw Exception("Data dengan email $email tidak ditemukan");
    }
  }

  //  ---------- METHOD TAMBAH USER ----------  //
  static Future<void> tambahUser({required MyUser user}) async {
    DocumentReference docref = tbUser.doc(user.email);
    await docref
        .set(user.toJson())
        .whenComplete(() => "Pengguna berhasil ditambahkan")
        .catchError((e) => print(e));
  }

  //  ---------- METHOD DETAIL ----------  //
  static Future<DataGame> getdataGame({required String name}) async {
    QuerySnapshot querySnapshot =
        await tbDataGame.where("name", isEqualTo: name).get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot docSnapshot = querySnapshot.docs.first;
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
      return DataGame.fromJson(data);
    } else {
      throw Exception("Data dengan judul $name tidak ditemukan");
    }
  }

  static Future<DataGame> getDataGameGrid() async {
    QuerySnapshot querySnapshot = await tbDataGame.get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot docSnapshot = querySnapshot.docs.first;
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
      return DataGame.fromJson(data);
    } else {
      throw Exception("Data tidak ditemukan");
    }
  }

  static Future<String> uploadImage(File imageFile) async {
    String fileName = basename(imageFile.path);
    Reference ref = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = ref.putFile(imageFile);
    TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
    if (snapshot.state == TaskState.success) {
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } else {
      throw ('File upload failed, status: ${snapshot.state}');
    }
  }
}
