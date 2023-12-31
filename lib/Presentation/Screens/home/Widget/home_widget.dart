import 'package:flutter/material.dart';
import 'package:socialmedia/Presentation/Screens/Home/Widget/post.dart';
import 'package:socialmedia/Presentation/Screens/home/Widget/story.dart';
import 'package:socialmedia/Presentation/Screens/home/screen/activity.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.camera_alt_outlined),
          title: const Text(
            "Social Media",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) => const ActivityScreen()),
                  ),
                );
              },
              icon: const Icon(Icons.favorite_outline),
            ),
          ],
        ),
        body: Column(
          children: [
            StoryWidget(),
            const Expanded(
              child: PostWidget(),
            )
          ],
        ),
      ),
    );
  }
}
