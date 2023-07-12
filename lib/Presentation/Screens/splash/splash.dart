// import 'dart:js';

import 'package:flutter/material.dart';

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
    // TODO: implement initState
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
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => const EntryPage(),
      ),
    );
  }
}
