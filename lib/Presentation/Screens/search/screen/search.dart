// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:socialmedia/Presentation/Screens/profile/screen/followers_screen.dart';
import 'package:socialmedia/Presentation/Screens/user/screens/user_profile.dart';

class SearchScreen extends StatelessWidget {
  List<dynamic> search = [
    {"images": "assets/images/storyprofile.jpeg", "username": "name"},
    {"images": "assets/images/storyprofile.jpeg", "username": "name"},
    {"images": "assets/images/storyprofile.jpeg", "username": "name"},
    {"images": "assets/images/storyprofile.jpeg", "username": "name"},
    {"images": "assets/images/storyprofile.jpeg", "username": "name"},
    {"images": "assets/images/storyprofile.jpeg", "username": "name"},
  ];
  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    
                    decoration: InputDecoration(
                      
                      hintText: "Search Here",
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear_rounded),
                        onPressed: () {},
                      ),
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {},
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(search.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.start,
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
                                        image: AssetImage(
                                            "${search[index]["images"]}"),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                UserProfile())));
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Username",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        "name",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
