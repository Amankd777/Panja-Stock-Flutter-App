import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:page_transition/page_transition.dart';
import 'package:panja/screens/stockscreens/endpoints.dart';
import 'package:panja/screens/stockscreens/extension.dart';
import 'package:panja/screens/stockscreens/search.dart';
import 'package:http/http.dart' as http;
import 'AuthMethods/login.dart';
import 'navbar.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class AddPage extends StatefulWidget {
  AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: [
      ListTile(
          leading: Text("Logout"),
          trailing: IconButton(
              onPressed: () async {
                await _auth.signOut();
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        alignment: Alignment.centerRight,
                        duration: const Duration(milliseconds: 600),
                        type: PageTransitionType.bottomToTopPop,
                        childCurrent: NavBar(),
                        child: LoginPage()));
              },
              icon: Icon(Icons.logout)))
    ]));
  }
}
