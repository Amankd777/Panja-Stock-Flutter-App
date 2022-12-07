import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:panja/AuthMethods/login.dart';
import 'package:panja/navbar.dart';

class Authenticate extends StatelessWidget {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    if (auth.currentUser != null) {
      return NavBar();
    } else {
      return LoginPage();
    }
  }
}
