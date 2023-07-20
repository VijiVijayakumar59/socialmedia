import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:socialmedia/Data/common/colors.dart';
import 'package:socialmedia/Presentation/Screens/authentication/screen/sign_up.dart';
import 'package:socialmedia/Presentation/Screens/home/screen/home.dart';

import '../../../services/firebase_services.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
bool passwordenable = true;

class _SignInPageState extends State<SignInPage> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  height: 800,
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
                          "Sign in now",
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
                          "Please sign in to continue our app",
                          style: TextStyle(
                              letterSpacing: 0.5,
                              color: twhitecolor,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.08,
                        ),
                        TextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value!.isEmpty ||
                                !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                              return "Enter Valid Email";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
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
                        TextFormField(
                          controller: passwordController,
                          obscureText: passwordenable,
                          enableSuggestions: false,
                          autocorrect: false,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 6) {
                              return "Enter Valid Password";
                            } else {
                              return null;
                            }
                          },
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
                            hintText: 'Password',
                            filled: true,
                            fillColor: twhitecolor,
                            isDense: true, // Added this
                            contentPadding: const EdgeInsets.all(5),
                            suffix: IconButton(
                              onPressed: () {
                                setState(() {
                                  if (passwordenable) {
                                    passwordenable = false;
                                  } else {
                                    passwordenable = true;
                                  }
                                });
                              },
                              icon: Icon(passwordenable == true
                                  ? Icons.remove_red_eye
                                  : Icons.lock_outline),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Text(
                              "Forget Password",
                              style: TextStyle(
                                color: maincolor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.08,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              log('validation success');
                              
                              FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: emailController.text,
                                      password: passwordController.text)
                                  .then((value) {
                                log('Login success');
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomeScreen(),
                                    )).onError((error, stackTrace) {});
                              });
                            }
                          },
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
                            "Sign In",
                            style: TextStyle(
                              color: twhitecolor,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Expanded(
                              child: Divider(
                                color: Colors.white,
                                thickness: 2,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              child: const Text(
                                "or sign in with",
                                style: TextStyle(
                                  color: twhitecolor,
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Divider(
                                color: Colors.white,
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await FirebaseServices().signInWithGoogle();
                            // ignore: use_build_context_synchronously
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ));
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: twhitecolor,
                                ),
                                image: const DecorationImage(
                                    image: AssetImage(
                                        'assets/images/google.png'))),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account?",
                              style:
                                  TextStyle(color: twhitecolor, fontSize: 15),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: ((context) =>
                                        const SignUpPage())));
                              },
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(color: maincolor),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
