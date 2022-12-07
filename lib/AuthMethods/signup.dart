import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:panja/AuthMethods/verify.dart';
import 'package:sizer/sizer.dart';

import 'authmethods.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool passwordnotVisible = true;
  bool isLoading = false;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  CollectionReference stds = FirebaseFirestore.instance.collection('Students');

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController username = TextEditingController();

// BRANCH

  List<String> branch = ["DSAI", "CSE", "ECE"];
  String selected_branch = "DSAI";
  String? dropdownNames;
  String dropdownScrollable = "I";

// VERSION

  List<String> version = ["Student", "Faculty", "Warden", "Administration"];
  String selected_version = "Student";
  String? dropdownVersion;
  String versionScrollable = "i";

  String? gender;

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
          backgroundColor: Colors.black,
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(5.w, 30.w, 0, 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 20.h,
                      width: 95.w,
                      child: Image.asset("assets/images/sign.png")),
                  SizedBox(height: 3.h),
                  Padding(
                    padding: EdgeInsets.all(4.w),
                    child: Text("Sign Up",
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w700)),
                  ),
                  // USERNAME TFF
                  Container(
                    width: 90.w,
                    height: 12.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Color(0xff363333),
                    ),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: username,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: " Username",
                        hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w200),
                        prefixIcon: Icon(Icons.person_rounded,
                            color: Colors.white, size: 18),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 90.w,
                    height: 12.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Color(0xff363333),
                    ),
                    child: TextFormField(
                      controller: email,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: " Email ID",
                        hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w200),
                        prefixIcon: Icon(Icons.mail_rounded,
                            color: Colors.white, size: 18),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 90.w,
                    height: 12.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Color(0xff363333),
                    ),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: password,
                      obscureText: passwordnotVisible,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: " Password",
                        hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w200),
                        prefixIcon: Icon(Icons.lock_person_rounded,
                            color: Colors.white, size: 18),
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            passwordnotVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Color(0xffAA661C),
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              passwordnotVisible = !passwordnotVisible;
                            });
                          },
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 14.w),
                  Row(
                    children: [
                      SizedBox(width: 14.w),
                    ],
                  ),

                  SizedBox(height: 13.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(20.w),
                        splashColor: Colors.grey[50],
                        highlightColor: Colors.grey[50],
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Ink(
                            height: 12.w,
                            width: 30.w,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(20.w)),
                            child: Center(
                                child: Text("Cancel",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.sp)))),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(20.w),
                        splashColor: Color.fromARGB(255, 246, 180, 94),
                        highlightColor: Color.fromARGB(255, 246, 180, 94),
                        onTap: () async {
                          setState(() {
                            isLoading = true;
                          });
                          await AuthMethods()
                              .signUpUser(
                            email: email.text.trim(),
                            password: password.text.trim(),
                            username: username.text.trim(),
                          )
                              .then((user) {
                            if (user != null) {
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => VerifyScreen()));
                              print("Account Created Sucessfull");
                            } else {
                              print("Login Failed");
                              setState(() {});
                            }
                          });
                        },
                        child: Ink(
                            height: 12.w,
                            width: 30.w,
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color(0xffFBA30A),
                                      Color(0xffDD0D76)
                                    ]),
                                borderRadius: BorderRadius.circular(20.w)),
                            child: Center(
                                child: isLoading
                                    ? CircularProgressIndicator(
                                        color: Colors.white)
                                    : Text("SignUp",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.sp)))),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ));
    });
  }
}
