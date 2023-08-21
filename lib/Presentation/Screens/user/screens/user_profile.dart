// ignore_for_file: sort_child_properties_last, use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia/Data/common/colors.dart';
import 'package:socialmedia/Presentation/Screens/authentication/screen/sign_up.dart';
import 'package:socialmedia/provider/follow_state.dart';
import '../../profile/widgets/profile_values.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({
    super.key,
    required this.name,
    required this.image,
    required this.profession,
    required this.followers,
    required this.following,
    required this.email,
    required this.id,
    required this.posts,
  });
  final String name;
  final String image;
  final String profession;
  final List<dynamic> posts;
  final List<dynamic> followers;
  final List<dynamic> following;
  final String email;
  final String id;

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  void toggleFollow() async {
    FollowState followState = Provider.of<FollowState>(context, listen: false);
    final CollectionReference collection =
        FirebaseFirestore.instance.collection('Users');
    String followingUserId = widget.email;
    String? currentUserId = FirebaseAuth.instance.currentUser?.email;
    final currentUserDoc = collection.doc(currentUserId);
    print(currentUserId);
    QuerySnapshot followingDoc = await collection
        .where("following", arrayContains: followingUserId)
        .get();

    if (followingDoc.docs.isEmpty) {
      currentUserDoc.update({
        "following": FieldValue.arrayUnion([followingUserId])
      }).then((value) {
        print("current user Document updated");
      }).onError((error, stackTrace) {
        print("error while updating current doc:$error");
      });
      final followUserDoc = collection.doc(followingUserId);
      followUserDoc.update({
        "followers": FieldValue.arrayUnion([currentUserId])
      }).then((value) {
        print("following user document updated");
      }).onError((error, stackTrace) {
        print("error while updating following doc:$error");
      });
      followState.setFollowingState(!followState.isFollowing);
      print("not following");
    } else {
      currentUserDoc.update({
        "following": FieldValue.arrayRemove([followingUserId])
      }).then((value) {
        print("current user Document updated");
      }).onError((error, stackTrace) {
        print("error while updating current doc:$error");
      });
      final followUserDoc = collection.doc(followingUserId);
      followUserDoc.update({
        "followers": FieldValue.arrayRemove([currentUserId])
      }).then((value) {
        print("following user document updated");
      }).onError((error, stackTrace) {
        print("error while updating following doc:$error");
      });
      followState.setFollowingState(!followState.isFollowing);
      print("Already following");
    }
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
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .where('id', isEqualTo: widget.id)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data?.docs.first;

              return Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 200,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/Dynamic_Variations.png"),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 150,
                        right: 150,
                        child: Container(
                          // width: 70,
                          // height: 76,
                          width: MediaQuery.of(context).size.width * 0.07,
                          height: MediaQuery.of(context).size.height * 0.08,
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
                              // width: 68,
                              // height: 68,
                              width: MediaQuery.of(context).size.width * 0.07,
                              height: MediaQuery.of(context).size.height * 0.08,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(data!['image']),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    data['name'] ?? "n/a",
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ProfileFollowing(
                          value: data['posts'].length.toString(),
                          titles: "Posts"),
                      ProfileFollowing(
                          value: data['followers'].length.toString(),
                          titles: "Followers"),
                      ProfileFollowing(
                          value: data["following"].length.toString(),
                          titles: "Following"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Consumer<FollowState>(
                        builder: (context, followState, _) {
                          return ElevatedButton(
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
                              followState.isFollowing ? 'Following' : 'Follow',
                              style: const TextStyle(
                                color: twhitecolor,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          );
                        },
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
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              return Text("something went wrong");
            }
          },
        ),
      ),
    );
  }
}
