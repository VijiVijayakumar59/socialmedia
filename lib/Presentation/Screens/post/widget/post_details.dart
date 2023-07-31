// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/Data/common/colors.dart';
import 'package:socialmedia/Data/models/post_model.dart';
import 'package:socialmedia/Presentation/Screens/home/screen/home.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final CollectionReference postsCollection = firestore.collection('Posts');

class PostDetails extends StatefulWidget {
  const PostDetails({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

TextEditingController captionController = TextEditingController();
TextEditingController locationController = TextEditingController();
TextEditingController usernameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController postIdController = TextEditingController();
TextEditingController commentController = TextEditingController();

class _PostDetailsState extends State<PostDetails> {
  final postKey = GlobalKey<FormState>();
  String? postImage;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: twhitecolor,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios)),
          title: const Text(
            "New Post",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (postKey.currentState!.validate()) {
                  Posts data = Posts(
                    // comments: int.parse(commentController.text.trim()),
                    location: locationController.text.trim(),
                    username: usernameController.text.trim(),
                    description: captionController.text.trim(),
                    email: emailController.text.trim(),
                    postId: postIdController.text.trim(),
                    postImage: postImage,
                  );
                  await addPosts(data, context);
                }
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
              child: const Text(
                "Post",
                style: TextStyle(
                  color: torangecolor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: postKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 200,
                        width: 180,
                        color: tblackcolor,
                        child: Image.network(widget.imageUrl),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  TextFormField(
                    controller: captionController,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'This field cannot be empty';
                      }
                      return null;
                    },
                    maxLines: 3,
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      hintText: " Add Caption...",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: tblackcolor),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      filled: true,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  TextFormField(
                    controller: locationController,
                    maxLines: 1,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.location_on_outlined),
                      focusedBorder: InputBorder.none,
                      hintText: " Add Location...",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: tblackcolor),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      filled: true,
                    ),
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

Future<void> addPosts(Posts postsModel, BuildContext context) async {
  final post = FirebaseFirestore.instance.collection('Posts');
  final reference = post.doc();
  final String email = FirebaseAuth.instance.currentUser!.email!;
  try {
    await reference.set({
      'comments': postsModel.comments,
      'description': postsModel.description,
      'email': email,
      'likes': 0,
      'location': postsModel.location,
      'postId': postsModel.postId,
      'postImage': postsModel.postImage,
      'username': postsModel.username,
    }).then((value) {
      Navigator.of(context).pop();
    });
  } catch (error) {
    log("Failed to add post: $error");
  }
}
