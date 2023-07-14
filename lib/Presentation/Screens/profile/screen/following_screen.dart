import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

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
  const FollowingScreen({super.key});

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
            children: List.generate(Following.length, (index) {
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
                          image: const DecorationImage(
                            fit: BoxFit.fill,
                            image:
                                AssetImage('assets/images/storyprofile.jpeg'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Username",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                      Text("Name"),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      changeButtonText();
                    },
                    style: ElevatedButton.styleFrom(
                      splashFactory: NoSplash.splashFactory,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                      side: BorderSide(color: Colors.grey.shade300),
                      primary: torangecolor,
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
        })),
      ),
    );
  }
}
