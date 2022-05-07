import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../shared/constants.dart';
import '../shared/functions.dart';
import 'auth/signin_screen.dart';
import 'home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        User? userAuth = FirebaseAuth.instance.currentUser;
        Timer(
          Duration(seconds: 3),
          () {
            Functions.navigatorPushAndRemove(
              context: context,
              screen: userAuth == null ? SignInScreen() : HomeScreen(),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: Constants.linearGradient,
        ),
        child: Icon(
          Icons.favorite,
          size: 50,
          color: Colors.white,
        ),
      ),
    );
  }
}
