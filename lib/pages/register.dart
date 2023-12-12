import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sorotangame/pages/login_page.dart';
import 'package:sorotangame/server/firebase_auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isPasswordVisible = false;
  final _emailTextfieldcontroller = TextEditingController();
  final _passwordTextfieldcontroller = TextEditingController();
  final _nameTextfieldcontroller = TextEditingController();
  final _phoneNumberTextfieldcontroller = TextEditingController();
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');
  final FirebaseAuthService _auth = FirebaseAuthService();

  @override
  void dispose() {
    _emailTextfieldcontroller.dispose();
    _passwordTextfieldcontroller.dispose();
    _nameTextfieldcontroller.dispose();
    _phoneNumberTextfieldcontroller.dispose();
    super.dispose();
  }

  void signUp() async {
    String email = _emailTextfieldcontroller.text;
    String password = _passwordTextfieldcontroller.text;
    String name = _nameTextfieldcontroller.text;
    String phoneNumber = _phoneNumberTextfieldcontroller.text;
    User? user = await _auth.registerwithEmailandPassword(email, password);
    await _users.doc(user!.uid).set({
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
    });
    if (user != null) {
      print("Register Success");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Register Success!"),
        backgroundColor: Colors.green,
      ));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Error Register! Try again"),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/SignUp.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 40),
                _buildInputField(
                    'Full Name', Icons.person, _nameTextfieldcontroller),
                const SizedBox(height: 15),
                _buildInputField('Phone Number', Icons.phone,
                    _phoneNumberTextfieldcontroller),
                const SizedBox(height: 15),
                _buildInputField(
                    'Email', Icons.email, _emailTextfieldcontroller),
                const SizedBox(height: 15),
                _buildPasswordInputField(
                  'Password',
                  Icons.lock,
                ),
                const SizedBox(height: 30),
                _buildRegisterButton(),
                const SizedBox(height: 20),
                _buildRegisterLink(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
      String hintText, IconData icon, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.purple),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
          border: OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildPasswordInputField(String hintText, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.purple),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: _passwordTextfieldcontroller,
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
          border: OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: Icon(
            icon,
            color: Colors.white,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
            child: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.white,
            ),
          ),
        ),
        obscureText: !_isPasswordVisible,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildRegisterLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Have an account? ",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
              (route) => false,
            );
          },
          child: Text(
            "Login",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: Row(
        children: [
          Expanded(
            child: MaterialButton(
              color: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              onPressed: () => signUp(),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                child: Text(
                  "Register",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
