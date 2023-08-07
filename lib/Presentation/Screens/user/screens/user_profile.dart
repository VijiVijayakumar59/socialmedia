// ignore_for_file: sort_child_properties_last

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:socialmedia/Data/common/colors.dart';
import '../../profile/widgets/profile_values.dart';

class UserProfile extends StatefulWidget {
  const UserProfile(
      {super.key,
      required this.name,
      required this.image,
      required this.profession,
      required this.followers,
      required this.following,
      required this.email,
      required this.id,
      required this.posts});
  final String name;
  final String image;
  final String profession;
  final int posts;
  final int followers;
  final int following;
  final String email;
  final String id;

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool isFollowing = false;

  void toggleFollow() async {
    String currentEmail = FirebaseAuth.instance.currentUser!.email!;
    final CollectionReference collection =
        FirebaseFirestore.instance.collection('User');

    QuerySnapshot querySnapshotUser =
        await collection.where('email', isEqualTo: widget.email).get();
    QuerySnapshot querySnapshotCurrent =
        await collection.where('email', isEqualTo: currentEmail).get();

    if (querySnapshotUser.docs.isNotEmpty &&
        querySnapshotCurrent.docs.isNotEmpty) {
      DocumentSnapshot userDocument = querySnapshotUser.docs.first;
      DocumentSnapshot currentDocument = querySnapshotCurrent.docs.first;

      int followersCount = userDocument.get('followers') ?? 0;
      int followingCount = currentDocument.get('following') ?? 0;

      if (isFollowing) {
        // Unfollow the user.
        int newFollowersCount = followersCount - 1;
        int newFollowingCount = followingCount - 1;

        await userDocument.reference.update({'followers': newFollowersCount});
        await currentDocument.reference
            .update({'following': newFollowingCount});
      } else {
        // Follow the user.
        int newFollowersCount = followersCount + 1;
        int newFollowingCount = followingCount + 1;

        await userDocument.reference.update({'followers': newFollowersCount});
        await currentDocument.reference
            .update({'following': newFollowingCount});
      }

      setState(() {
        isFollowing = !isFollowing;
      });
    }

    log("its working");
  }

  @override
  Widget build(BuildContext context) {
    String email = FirebaseAuth.instance.currentUser!.email!;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            widget.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
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
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(widget.image),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              widget.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ProfileFollowing(
                    value: widget.posts.toString(), titles: "Posts"),
                ProfileFollowing(
                    value: widget.followers.toString(), titles: "Followers"),
                ProfileFollowing(
                    value: widget.following.toString(), titles: "Following"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: toggleFollow,
                  style: ElevatedButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    backgroundColor: torangecolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                    side: BorderSide(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  child: Text(
                    isFollowing ? 'Following' : 'Follow',
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
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Posts')
                    .where('email', isEqualTo: widget.email)
                    .where('email', isNotEqualTo: email)
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
                  return const CircularProgressIndicator();
                }),
          ],
        ),
      ),
    );
  }
}
