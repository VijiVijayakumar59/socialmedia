import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:socialmedia/Data/common/colors.dart';

import '../widget/logout.dart';
import '../widget/settings_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: twhitecolor,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: const Text(
            "Settings and Privacy",
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        body: Column(children: [
          SettingsWidget(
            items: "Terms and Conditions",
            icon: Icons.event_note_sharp,
            onpressed: () {},
          ),
          SettingsWidget(
            items: "Privacy & Policy",
            icon: Icons.policy_outlined,
            onpressed: () {},
          ),
          SettingsWidget(
            items: "Community Guidelines",
            icon: Icons.people_sharp,
            onpressed: () {},
          ),
          SettingsWidget(
            items: "Support",
            icon: Icons.contact_support_rounded,
            onpressed: () {},
          ),
          SettingsWidget(
            items: "Log Out",
            icon: Icons.login_outlined,
            onpressed: () {
              showLogoutAlertDialog(context);
            },
          ),
        ]),
      ),
    );
  }
}
