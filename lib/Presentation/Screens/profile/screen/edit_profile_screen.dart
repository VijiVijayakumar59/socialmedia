import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:socialmedia/Data/common/colors.dart';

import '../widgets/edit_widget.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: twhitecolor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text("Edit Profile"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.check_rounded))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(children: [
                  const CircleAvatar(
                    radius: 55,
                    backgroundImage:
                        AssetImage("assets/images/storyprofile.jpeg"),
                  ),
                  Positioned(
                    bottom: 0,
                    right: -12,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.camera_alt,
                        size: 25,
                      ),
                    ),
                  )
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 14),
                child: Text(
                  "PUBLIC INFORMATION",
                  style:
                      TextStyle(fontWeight: FontWeight.w700, color: tgreycolor),
                ),
              ),
              const Textfield(name: "First Name"),
              const Textfield(name: "Last Name"),
              const Textfield(name: "Location"),
              const Textfield(name: "Phone"),
              const Textfield(name: "mail"),
            ],
          ),
        ),
      ),
    );
  }
}
