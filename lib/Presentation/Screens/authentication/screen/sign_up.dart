import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:socialmedia/Presentation/Screens/authentication/screen/sign_in.dart';

import '../../../../Data/common/colors.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: 500,
          color: Colors.black87,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.11,
                ),
                const Text(
                  "Sign up now",
                  style: TextStyle(
                      letterSpacing: 0.8,
                      color: maincolor,
                      fontSize: 28,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                const Text(
                  "Please fill the details and create account",
                  style: TextStyle(
                      // letterSpacing: 0.5,
                      color: twhitecolor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                ),
                TextField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person,
                      color: tgreycolor,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: maincolor),
                      borderRadius: BorderRadius.circular(15.0),
                    ),

                    hintText: 'Username',
                    filled: true,
                    fillColor: twhitecolor,
                    isDense: true, // Added this
                    contentPadding: const EdgeInsets.all(18),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                TextField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.mail,
                      color: tgreycolor,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: maincolor),
                      borderRadius: BorderRadius.circular(15.0),
                    ),

                    hintText: 'Email/phone',
                    filled: true,
                    fillColor: twhitecolor,
                    isDense: true, // Added this
                    contentPadding: const EdgeInsets.all(18),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                TextField(
                  cursorWidth: 2,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                      color: tgreycolor,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: maincolor),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    suffixIcon: Icon(
                      Icons.visibility_off,
                      color: tgreycolor,
                    ),
                    hintText: 'Password',
                    filled: true,
                    fillColor: twhitecolor,
                    isDense: true, // Added this
                    contentPadding: const EdgeInsets.all(18),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 0,
                    side: BorderSide(color: Colors.grey.shade300),
                    primary: maincolor,
                    minimumSize: const Size.fromHeight(50), // NEW
                  ),
                  child: const Text(
                    "Sign up",
                    style: TextStyle(
                      color: twhitecolor,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Row(
                  children: const [
                    Divider(
                      color: Colors.white,
                      height: 60,
                      thickness: 2,
                      indent: 0,
                      endIndent: 140,
                    ),
                    Text(
                      "Or connect with",
                      style: TextStyle(
                        color: twhitecolor,
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                      height: 30,
                      thickness: 2,
                      indent: 120,
                      endIndent: 0,
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: twhitecolor,
                      ),
                      image: const DecorationImage(
                          image: AssetImage('assets/images/google.png'))),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(color: twhitecolor, fontSize: 15),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => const SignInPage())));
                      },
                      child: const Text(
                        "Sign in",
                        style: TextStyle(color: maincolor),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
