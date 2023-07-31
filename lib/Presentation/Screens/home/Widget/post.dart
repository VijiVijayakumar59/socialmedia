// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/Data/common/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PostWidget extends StatelessWidget {
  // final String imageUrl;
  const PostWidget({
    super.key,
    // required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    String email = FirebaseAuth.instance.currentUser!.email!;
    // return ListView.builder(
    //   // physics: NeverScrollableScrollPhysics(),
    //   itemCount: 3,
    //   itemBuilder: (context, index) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Posts')
            .where('email', isEqualTo: email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData && snapshot.data != null) {
            final List<DocumentSnapshot> documents = snapshot.data!.docs;
            // bool available = documents.isNotEmpty;
            // if (documents.isNotEmpty) {
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final document = documents[index];
                final imageUrl = document.get('postImage') as String?;
                final location = document.get('location') as String?;
                final likes = document.get('likes').toString();
                final description = document.get('description') as String?;

                final imageUrlValue = imageUrl ?? '';
                final locationValue = location ?? '';
                final likesValue = likes ?? 0;
                final descriptionValue = description ?? '';
                return Column(
                  children: [
                    ListTile(
                      leading: Container(
                        width: 48,
                        height: 48,
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
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              shape: BoxShape.rectangle,
                              image: const DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('assets/images/post2.jpg'),
                                // image: NetworkImage(
                                //   documents[0].get('image'),
                                // ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        location ?? '',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: const Text(""),
                      // trailing: IconButton(
                      //     onPressed: () {
                      //     },
                      //     icon: const Icon(
                      //       Icons.more_vert_rounded,
                      //     ),
                      // ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, top: 2, right: 8),
                      child: Container(
                        height: 300,
                        // width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            // image: AssetImage("assets/images/post4.jpeg"),
                            image: NetworkImage(
                              imageUrl!,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Wrap(
                        spacing: 10,
                        children: [
                          const Icon(
                            Icons.favorite,
                            size: 32,
                            color: maincolor,
                          ),
                          SvgPicture.asset(
                            "assets/images/comment.svg",
                            width: 33,
                          ),
                          SvgPicture.asset(
                            "assets/images/share.svg",
                            width: 28,
                          )
                        ],
                      ),
                      trailing: Icon(
                        Icons.bookmark_border_outlined,
                        size: 28,
                        color: tblackcolor,
                      ),
                    ),
                    Row(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text(
                          likes,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ]),
                    Row(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, right: 18),
                        child: Container(
                          // width: 350,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Text(
                            description!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ]),
                    ListTile(
                      leading: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(),
                            image: const DecorationImage(
                              image: AssetImage('assets/images/post2.jpg'),
                            )),
                      ),
                      title: TextFormField(
                        textAlign: TextAlign.start,
                        cursorColor: tblackcolor,
                        cursorHeight: 18,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "Add a comment",
                            labelStyle: TextStyle(
                              color: tblackcolor,
                            )),
                      ),
                      trailing: Wrap(
                        spacing: 10,
                        children: [
                          TextButton(
                            style: const ButtonStyle(),
                            onPressed: () {},
                            child: const Text("post"),
                          ),
                          const Icon(
                            Icons.favorite,
                            size: 18,
                            color: maincolor,
                          ),
                          const Icon(
                            Icons.add_circle_outline,
                            size: 18,
                            color: maincolor,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
          // } else {
          //   return const Center(
          //     child: Text('No data available.'),
          //   );
          // }
        });
    //   },
    // );
  }
}
