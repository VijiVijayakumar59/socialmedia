import 'package:flutter/material.dart';

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
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Log Out'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
