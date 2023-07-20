import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:socialmedia/Data/common/colors.dart';

import '../../settings/screens/settings_screen.dart';
import '../widgets/profile_values.dart';
import 'edit_profile_screen.dart';

List<String> imageUrls = [
  'assets/images/post.jpg',
  'assets/images/post2.jpg',
  'assets/images/post3.jpeg',
  'assets/images/post4.jpeg',
  'assets/images/post.jpg',
  'assets/images/post2.jpg',
  'assets/images/post3.jpeg',
  'assets/images/post4.jpeg',
  'assets/images/post.jpg',
  'assets/images/post2.jpg',
  'assets/images/post3.jpeg',
  'assets/images/post4.jpeg',
];

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "_Selena_Gomez",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => const SettingsScreen())));
              },
              icon: const Icon(Icons.settings),
            ),
          ],
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.12,
                  ),
                  const CircleAvatar(
                    radius: 48,
                    backgroundImage:
                        AssetImage("assets/images/storyprofile.jpeg"),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.12,
                  ),
                ],
              ),
              const Text(
                "Selena Gomez",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const Text(
                "Musician/band",
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.22,
                  ),
                  const ProfileFollowing(value: "55", titles: "Posts"),
                  const ProfileFollowing(value: "435", titles: "Followers"),
                  const ProfileFollowing(value: "12", titles: "Following"),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => const EditProfile())));
                },
                style: ElevatedButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 0,
                  side: BorderSide(color: Colors.grey.shade300),
                  primary: twhitecolor,
                  minimumSize: const Size.fromHeight(35),
                ),
                child: Text(
                  "Edit Profile",
                  style: TextStyle(
                    color: tblackcolor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const CircleAvatar(
                radius: 22,
                backgroundImage: AssetImage("assets/images/grid2.jpg"),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: imageUrls
                      .length, // Replace with your desired number of images
                  itemBuilder: (ctx, index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        // ignore: sort_child_properties_last
                        child: Image.asset(
                          imageUrls[index],
                          fit: BoxFit.cover,
                        ),
                        color: Colors.grey, // Replace with your image logic
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
