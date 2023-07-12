import 'package:flutter/material.dart';
import 'package:socialmedia/Data/common/colors.dart';

// ignore: must_be_immutable
class StoryWidget extends StatelessWidget {
  List<dynamic> story = [
    {"images": "assets/images/storyprofile.jpeg", "username": "name"},
    {"images": "assets/images/storyprofile.jpeg", "username": "name"},
    {"images": "assets/images/storyprofile.jpeg", "username": "name"},
    {"images": "assets/images/storyprofile.jpeg", "username": "name"},
    {"images": "assets/images/storyprofile.jpeg", "username": "name"},
    {"images": "assets/images/storyprofile.jpeg", "username": "name"},
  ];

  StoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 6,
      ),
      child: Column(children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(story.length, (index) {
                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
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
                                image: AssetImage('${story[index]["images"]}'),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          "${story[index]["username"]}",
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                );
              })),
        ),
        Divider(
          height: 0.1,
          thickness: 0.2,
          color: tgreycolor,
        ),
      ]),
    );
  }
}
