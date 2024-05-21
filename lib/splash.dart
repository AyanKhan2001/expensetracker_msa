import 'dart:async';

import 'package:expensetracker_msa/home_page.dart';
import 'package:flutter/material.dart';

import 'auth.dart';




class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) =>SignupScreen()),
      );
    });

    return Scaffold(
      body: Center(
        child: Image.asset("images/ss.png",
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}
