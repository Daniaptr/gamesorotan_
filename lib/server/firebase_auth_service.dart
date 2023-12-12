import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  // login
  Future<User?> loginwithEmailandPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print(credential.user);
      return credential.user;
    } catch (e) {
      return null;
    }
  }

  // register
  Future<User?> registerwithEmailandPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print(credential.user);
      return credential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  void signOut() async {
    await _auth.signOut();
  }
}
