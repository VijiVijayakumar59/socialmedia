import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/Presentation/Screens/authentication/screen/sign_in.dart';
import 'package:socialmedia/Presentation/services/firebase_services.dart';

import '../../../../Data/common/colors.dart';

void showLogoutAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Log Out',
          style: TextStyle(color: torangecolor),
        ),
        content: const Text('Are you sure you want to log out?'),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'Cancel'),
            onPressed: () {},
          ),
          TextButton(
            child: const Text('Log Out'),
            onPressed: () async {
              await FirebaseServices().signOut();

              FirebaseAuth.instance.signOut().then((value) {
                print("Signed Out");
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SignInPage(),
                ));
              });
            },
          ),
        ],
      );
    },
  );
}
