// ignore_for_file: sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/Data/common/colors.dart';
import 'package:socialmedia/Presentation/Screens/profile/screen/followers_screen.dart';
import 'package:socialmedia/Presentation/Screens/profile/screen/following_screen.dart';

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
    String email = FirebaseAuth.instance.currentUser!.email!;
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
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('User')
                      .where('email', isEqualTo: email)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final List<DocumentSnapshot> documents =
                          snapshot.data!.docs;

                      bool available = documents.isNotEmpty;
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.12,
                              ),
                              CircleAvatar(
                                radius: 48,
                                backgroundImage: NetworkImage(available
                                    ? documents[0].get('image')
                                    : 'https://www.cornwallbusinessawards.co.uk/wp-content/uploads/2017/11/dummy450x450.jpg'),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.12,
                              ),
                            ],
                          ),
                          Text(
                            available ? documents[0].get('name') : "Username",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            available
                                ? documents[0].get('profession')
                                : "Profession",
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.22,
                              ),
                              ProfileFollowing(
                                  value: available
                                      ? documents[0].get('posts').toString()
                                      : '0',
                                  titles: "Posts"),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => FollowersScreen(),
                                  ));
                                },
                                child: ProfileFollowing(
                                    value: available
                                        ? documents[0]
                                            .get('followers')
                                            .toString()
                                        : '0',
                                    titles: "Followers"),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => FollowingScreen(),
                                  ));
                                },
                                child: ProfileFollowing(
                                    value: available
                                        ? documents[0]
                                            .get('following')
                                            .toString()
                                        : '0',
                                    titles: "Following"),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                        ],
                      );
                    }
                    return const CircularProgressIndicator();
                  }),
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
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Posts')
                      .where('email', isEqualTo: email)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final List<DocumentSnapshot> documents =
                          snapshot.data!.docs;

                      return Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),

                          itemCount: documents
                              .length, // Replace with your desired number of images
                          itemBuilder: (ctx, index) {
                            return GestureDetector(
                              onTap: () {},
                              child: Container(
                                // ignore: sort_child_properties_last
                                // child: Image.asset(
                                //   imageUrls[index],
                                //   fit: BoxFit.cover,
                                // ),
                                child: Image.network(
                                  documents[index].get('postImage'),
                                  fit: BoxFit.cover,
                                ),

                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return CircularProgressIndicator();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
