import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:sizer/sizer.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
          backgroundColor: Colors.black,
          body: Container(
            width: 100.w,
            height: 100.h,
            alignment: Alignment.center,
            child: Center(
              child: SpinKitRipple(
                color: Colors.orangeAccent,
                size: 30.w,
              ),
            ),
          ));
    });
  }
}

class LoadingScreen2 extends StatelessWidget {
  const LoadingScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0XFFEEF3FC),
        appBar: AppBar(
            backgroundColor: Color(0XFF083668),
            elevation: 0,
            title: const Text(
              "COLLEGE VISION",
              style: TextStyle(
                color: Color(0XFFF1FAFF),
                fontSize: 18,
              ),
            ),
            flexibleSpace: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Color(0XFF2F80ED), Color(0XFF56CCF2)]))),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.logout_rounded),
              ),
            ]),
        body: SpinKitSpinningLines(color: Colors.deepPurple, size: 15.w));
  }
}

class LoadingScreen3 extends StatefulWidget {
  LoadingScreen3({Key? key}) : super(key: key);

  @override
  State<LoadingScreen3> createState() => _LoadingScreen3State();
}

class _LoadingScreen3State extends State<LoadingScreen3> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitCircle(
        color: Color(0xffEAC6D2),
        size: 15.w,
      ),
    );
  }
}

class LoadingScreen4 extends StatefulWidget {
  LoadingScreen4({Key? key}) : super(key: key);

  @override
  State<LoadingScreen4> createState() => _LoadingScreen4State();
}

class _LoadingScreen4State extends State<LoadingScreen4> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitCircle(
        color: Color(0xffEAC6D2),
        size: 15.w,
      ),
    );
  }
}
