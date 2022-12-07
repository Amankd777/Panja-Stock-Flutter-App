import 'dart:typed_data';

import 'package:panja/AuthMethods/storagemethods.dart';
import 'package:panja/models/stockmodel.dart' as model;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get user details

  // Signing Up User

  Future<String> signUpUser({
    required String email,
    required String username,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty) {
        // registering user in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // adding user in our database

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // logging in user
  Future<User?> logIn({required String email, required String password}) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Signing Up User

  Future<String> addDetails(
      {required String name,
      required String ticker,
      required Uint8List actual,
      required Uint8List predicted,
      required Uint8List predictedZoom}) async {
    String res = "Some error Occurred";
    try {
      if (name.isNotEmpty) {
        // registering user in auth with email and password

        String photoUrl1 = await StorageMethods()
            .uploadImageToStorage('StockImages', ticker, "1", actual, false);
        String photoUrl2 = await StorageMethods()
            .uploadImageToStorage('StockImages', ticker, "2", predicted, false);
        String photoUrl3 = await StorageMethods().uploadImageToStorage(
            'StockImages', ticker, "3", predictedZoom, false);

        model.Stock stock = model.Stock(
          name: name,
          ticker: ticker,
          actualUrl: photoUrl1,
          predictedUrl: photoUrl2,
          predictedZoomUrl: photoUrl3,
        );

        // adding user in our database
        await _firestore.collection("Stocks").doc(ticker).set(stock.toJson());

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }
}
