import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:page_transition/page_transition.dart';
import 'package:panja/AuthMethods/signup.dart';
import 'package:panja/navbar.dart';
import 'package:sizer/sizer.dart';

import '../loading.dart';
import 'authmethods.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool passwordnotVisible = true;
  bool isLoading = false;
  final auth = FirebaseAuth.instance;
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return isLoading
          ? LoadingScreen()
          : Scaffold(
              backgroundColor: Color(0xff000000),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(5.w, 30.w, 0, 5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: 20.h,
                          width: 95.w,
                          child: Image.asset("assets/images/panja.png")),
                      SizedBox(height: 3.h),
                      Padding(
                        padding: EdgeInsets.all(4.w),
                        child: Text("Login",
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
                      SizedBox(height: 10),

                      SizedBox(height: 10),

                      SizedBox(
                        height: 10,
                      ),

                      SizedBox(height: 10),

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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignupPage()));
                            },
                            child: Ink(
                                height: 12.w,
                                width: 30.w,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(20.w)),
                                child: Center(
                                    child: Text("SignUp",
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
                                  .logIn(
                                      email: email.text.trim(),
                                      password: password.text.trim())
                                  .then((user) {
                                if (user != null) {
                                  Navigator.pushReplacement(
                                      context,
                                      PageTransition(
                                          alignment: Alignment.centerRight,
                                          type: PageTransitionType.scale,
                                          child: NavBar()));
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
                                        : Text("Login",
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
