// ignore_for_file: unused_local_variable

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia/provider/follow_state.dart';
import 'Presentation/Screens/splash/splash.dart';

void main() async {
  GoogleSignIn googleSignIn = GoogleSignIn();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const SocialMedia());
}

class SocialMedia extends StatelessWidget {
  const SocialMedia({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FollowState>(
          create: (context) => FollowState(),
        ),
        // ChangeNotifierProvider<CommentProvider>(
        //   create: (context) => CommentProvider(),
        // )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.orange,
          fontFamily: "Nunito",
          primarySwatch:
              MaterialColor((const Color.fromARGB(235, 243, 192, 116).value), {
            50: Colors.orange.withOpacity(0.05),
            100: Colors.orange.withOpacity(0.1),
            200: Colors.orange.withOpacity(0.2),
            300: Colors.orange.withOpacity(0.3),
            400: const Color.fromARGB(255, 220, 145, 32).withOpacity(0.4),
            500: Colors.orange.withOpacity(0.5),
            600: Colors.orange.withOpacity(0.6),
            700: Colors.orange.withOpacity(0.7),
            800: Colors.orange.withOpacity(0.8),
            900: Colors.orange.withOpacity(0.9),
          }),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
