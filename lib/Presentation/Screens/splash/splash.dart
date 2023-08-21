// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:socialmedia/Presentation/Screens/authentication/screen/sign_in.dart';
import 'package:socialmedia/Presentation/Screens/home/screen/home.dart';
import '../authentication/screen/entry_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    gotoHome();
    super.initState();
  }

  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: 800,
          width: 400,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/entrypage pic.png"))),
        ),
      ),
    );
  }

  Future<void> gotoHome() async {
    await Future.delayed(const Duration(seconds: 3));
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => const SignInPage(),
          ),
        );
      } else {
        print('User is signed in!');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => const HomeScreen(),
          ),
        );
      }
    });
  }
}
