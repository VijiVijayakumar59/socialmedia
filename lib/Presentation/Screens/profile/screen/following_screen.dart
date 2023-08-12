// ignore_for_file: unused_local_variable, avoid_print
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../Data/common/colors.dart';

List<dynamic> Following = [
  {"images": "assets/images/storyprofile.jpeg", "username": "name"},
  {"images": "assets/images/storyprofile.jpeg", "username": "name"},
  {"images": "assets/images/storyprofile.jpeg", "username": "name"},
  {"images": "assets/images/storyprofile.jpeg", "username": "name"},
  {"images": "assets/images/storyprofile.jpeg", "username": "name"},
  {"images": "assets/images/storyprofile.jpeg", "username": "name"},
];

class FollowingScreen extends StatefulWidget {
  final String name;
  final String image;
  final String profession;
  final int followers;
  final int following;
  final String email;
  final String id;
  const FollowingScreen({
    super.key,
    required this.name,
    required this.image,
    required this.profession,
    required this.followers,
    required this.following,
    required this.email,
    required this.id,
  });

  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  String buttonText = 'Following';

  void changeButtonText() {
    setState(() {
      buttonText = 'Follow';
    });
  }

  @override
  Widget build(BuildContext context) {
    String email = FirebaseAuth.instance.currentUser!.email!;
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
            ),
          ),
          title: const Text(
            "Following",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: List.generate(
            Following.length,
            (index) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 67,
                        height: 67,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          shape: BoxShape.rectangle,
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.red, Colors.yellow],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            width: 65,
                            height: 65,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(widget.image),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                          Text(widget.profession),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          changeButtonText();
                          // print(widget.name);
                          // print(widget.email);
                        },
                        style: ElevatedButton.styleFrom(
                          splashFactory: NoSplash.splashFactory,
                          backgroundColor: torangecolor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                          side: BorderSide(color: Colors.grey.shade300),
                        ),
                        child: Text(
                          buttonText,
                          style: const TextStyle(
                            color: twhitecolor,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  )
                ]),
              );
            },
          ),
        ),
      ),
    );
  }
}
