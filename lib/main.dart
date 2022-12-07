import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:panja/AuthMethods/authenticate.dart';
import 'package:panja/AuthMethods/login.dart';
import 'package:panja/navbar.dart';

import 'screens/stockscreens/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Authenticate()));
}
