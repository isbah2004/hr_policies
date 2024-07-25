import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hr_policies/authsetup/login_screen.dart';
import 'package:hr_policies/homescreen/home_screen.dart';
class SplashServices {
 static void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if (user != null) {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const HomeScreen())));
    } else {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginScreen())));
    }
  }
}
