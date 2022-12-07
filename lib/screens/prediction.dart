import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import '../AuthMethods/authmethods.dart';
import '../AuthMethods/login.dart';
import '../AuthMethods/pickimage.dart';
import '../navbar.dart';
import 'displaypred.dart';

String predname = "";
String predval = "";
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

final FirebaseAuth _auth = FirebaseAuth.instance;

class Prediction extends StatefulWidget {
  Prediction({Key? key}) : super(key: key);

  @override
  State<Prediction> createState() => _PredictionState();
}

class _PredictionState extends State<Prediction> {
  datareturn() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Stocks').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          final userSnapshot = snapshot.data?.docs;
          if (userSnapshot!.isEmpty) {
            return const Text("no data");
          }
          return ListView.builder(
              itemCount: userSnapshot.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        predval = userSnapshot[index]["ticker"];
                        predname = userSnapshot[index]["name"];
                      });

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DisplayPred()));
                    },
                    child: Container(
                      height: 70,
                      width: 270,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xff1D2235),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: Text(
                                      userSnapshot[index]["ticker"][0] +
                                          userSnapshot[index]["ticker"][1],
                                      style: TextStyle(
                                          color: Colors.deepPurple[900],
                                          fontWeight: FontWeight.w600))),
                            ),
                            SizedBox(
                                width: 140,
                                child: Text(userSnapshot[index]["name"],
                                    style: TextStyle(color: Colors.white))),
                            SizedBox(
                                width: 120,
                                child: Center(
                                  child: Text(userSnapshot[index]["ticker"],
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 219, 16))),
                                )),
                          ]),
                    ),
                  ),
                );
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff10151E),
        appBar: AppBar(
            title: Text("Predict Stocks"),
            backgroundColor: Color(0xff10151E),
            elevation: 0),
        body: datareturn());
  }
}
