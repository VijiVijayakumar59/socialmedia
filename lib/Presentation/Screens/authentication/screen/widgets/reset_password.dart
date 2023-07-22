import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:socialmedia/Presentation/services/firebase_services.dart';

import '../../../../../Data/common/colors.dart';
import '../sign_in.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({super.key});
  final resetKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: torangecolor,
            ),
          ),
          backgroundColor: Colors.black87,
        ),
        body: Form(
          key: resetKey,
          child: SingleChildScrollView(
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
                          "Reset Password",
                          style: TextStyle(
                              letterSpacing: 0.8,
                              color: maincolor,
                              fontSize: 28,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
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

                            hintText: 'Enter Email id',
                            filled: true,
                            fillColor: twhitecolor,
                            isDense: true, // Added this
                            contentPadding: const EdgeInsets.all(18),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            FirebaseAuth.instance
                                .sendPasswordResetEmail(
                                    email: emailController.text)
                                .then(
                                  (value) => Navigator.of(context).pop(),
                                );
                          },
                          style: ElevatedButton.styleFrom(
                            splashFactory: NoSplash.splashFactory,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 0,
                            side: BorderSide(color: Colors.grey.shade300),
                            primary: maincolor,
                            minimumSize: const Size.fromHeight(50), 
                          ),
                          child: const Text(
                            "Reset Password",
                            style: TextStyle(
                              color: twhitecolor,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
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
