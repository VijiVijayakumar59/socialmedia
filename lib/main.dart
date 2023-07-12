import 'package:flutter/material.dart';
import 'Presentation/Screens/authentication/screen/sign_in.dart';
import 'Presentation/Screens/home/screen/home.dart';
import 'Presentation/Screens/search.dart/screen/search.dart';
import 'Presentation/Screens/splash/splash.dart';

void main() {
  runApp(const SocialMedia());
}

class SocialMedia extends StatelessWidget {
  const SocialMedia({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Nunito",
        primarySwatch:
            MaterialColor((const Color.fromARGB(235, 243, 192, 116).value), {
          50: Colors.orange.withOpacity(0.05),
          100: Colors.orange.withOpacity(0.1),
          200: Colors.orange.withOpacity(0.2),
          300: Colors.orange.withOpacity(0.3),
          400: Colors.orange.withOpacity(0.4),
          500: Colors.orange.withOpacity(0.5),
          600: Colors.orange.withOpacity(0.6),
          700: Colors.orange.withOpacity(0.7),
          800: Colors.orange.withOpacity(0.8),
          900: Colors.orange.withOpacity(0.9),
        }),
      ),
      home: SearchScreen(),
    );
  }
}
