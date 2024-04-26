import 'dart:async';

import 'package:flutter/material.dart';
import 'package:the_fire/routes/page_names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    waitAndNavigate();
    super.initState();
  }

  waitAndNavigate() async {
    // check if loggedIn user exists route to home else to Login
    Timer(const Duration(seconds: 2), () => Navigator.pushReplacementNamed(context, PageNames.registerScreen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Splash Screen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [],
      ),
    );
  }
}
