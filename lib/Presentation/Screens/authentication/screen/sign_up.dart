// ignore_for_file: deprecated_member_use, avoid_print
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/Presentation/Screens/authentication/screen/sign_in.dart';
import 'package:socialmedia/Presentation/Screens/home/screen/home.dart';
import 'package:socialmedia/Presentation/Screens/profile/screen/edit_profile_screen.dart';
import 'package:socialmedia/Presentation/services/firebase_services.dart';
import '../../../../Data/common/colors.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController confirmpasswordController = TextEditingController();

final GlobalKey<FormState> formKey = GlobalKey<FormState>();

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: 500,
          color: Colors.black87,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
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
                    kheight50,
                    kheight20,
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

                        hintText: 'Email',
                        filled: true,
                        fillColor: twhitecolor,
                        isDense: true, // Added this
                        contentPadding: const EdgeInsets.all(18),
                      ),
                    ),
                    kheight20,
                    TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value!.length < 6) {
                          return "Password is Incorrect";
                        } else {
                          return null;
                        }
                      },
                      cursorWidth: 2,
                      cursorColor: Colors.black,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
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
                    kheight20,
                    TextFormField(
                      controller: confirmpasswordController,
                      validator: (value) {
                        if (value != passwordController.text) {
                          return "Password is Incorrect";
                        } else {
                          return null;
                        }
                      },
                      cursorWidth: 2,
                      cursorColor: Colors.black,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
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
                        hintText: 'Confirm Password',
                        filled: true,
                        fillColor: twhitecolor,
                        isDense: true, // Added this
                        contentPadding: const EdgeInsets.all(18),
                      ),
                    ),
                    kheight50,
                    ElevatedButton(
                      onPressed: () {
                        _signUpUser(
                            email: emailController.text,
                            password: passwordController.text,
                            confirmPassword: confirmpasswordController.text);
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
                          endIndent: 120,
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
                          indent: 40,
                          endIndent: 0,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.001,
                    ),
                    InkWell(
                      onTap: () async {
                        final credential =
                            await FirebaseServices().signInWithGoogle();
                        // ignore: use_build_context_synchronously
                        print(credential.toString());
                        if (credential != null) {
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        }
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
                            image: AssetImage('assets/images/google.png'),
                          ),
                        ),
                      ),
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
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: ((context) => const SignInPage()),
                              ),
                            );
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
        ),
      ),
    );
  }

  Future<void> _signUpUser(
      {required String email,
      required String password,
      required String confirmPassword}) async {
    try {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        log('validation success');
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: email,
          password: password,
        )
            .then((userCred) {
          log('sign up success');
          emailController.clear();
          confirmpasswordController.clear();
          passwordController.clear();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const EditProfile(),
              ));
        }).onError((error, stackTrace) {
          log('Error ${error.toString()}');
        });
      }
    } catch (e) {
      log('Exception caught: ${e.toString()}');
    }
  }
}
