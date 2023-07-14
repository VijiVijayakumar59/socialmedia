// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:socialmedia/Data/common/colors.dart';

import '../../profile/screen/profile.dart';
import '../../profile/widgets/profile_values.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String buttonText = 'Follow';

  void changeButtonText() {
    setState(() {
      buttonText = 'Following';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text(
            "Username",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage("assets/images/Dynamic_Variations.png"),
                        fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 160,
                  right: 160,
                  child: Container(
                    width: 70,
                    height: 76,
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
                        height: 68,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          shape: BoxShape.rectangle,
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/user.jpg'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Text(
              "Username",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ProfileFollowing(value: "55", titles: "Posts"),
                ProfileFollowing(value: "4M", titles: "Followers"),
                ProfileFollowing(value: "12", titles: "Following"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    "assets/images/share.svg",
                    width: 24,
                  ),
                ),
              ],
            ),
            // CircleAvatar(
            //   radius: 22,
            //   backgroundImage: AssetImage("assets/images/grid2.jpg"),
            // ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(vertical: 10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: imageUrls.length,
                itemBuilder: (ctx, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      child: Image.asset(
                        imageUrls[index],
                        fit: BoxFit.cover,
                      ),
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
