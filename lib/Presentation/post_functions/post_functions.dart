// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Data/common/colors.dart';

final TextEditingController _commentController = TextEditingController();
void showCommentBottomSheet(BuildContext context, postId) {
  showModalBottomSheet<dynamic>(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          // height: 500,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _commentController,
                textAlign: TextAlign.start,
                cursorColor: tblackcolor,
                cursorHeight: 18,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: "Add a comment",
                  labelStyle: TextStyle(
                    color: tblackcolor,
                  ),
                  suffixIcon: TextButton(
                    style: const ButtonStyle(),
                    onPressed: () async {
                      final String commentText = _commentController.text;
                      if (commentText.isNotEmpty) {
                        saveCommentToFirebase(commentText, postId);
                        _commentController.clear();
                        Navigator.pop(context); // Close the bottom sheet
                      }
                    },
                    child: const Text("post"),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () {
                  // Handle comment submission here
                  String commentText = _commentController.text;
                  // Save the comment to Firebase, update UI, etc.
                  _commentController.clear();
                  Navigator.pop(context); // Close the bottom sheet
                },
                child: const Icon(Icons.clear),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void saveCommentToFirebase(String text, String postId) async {
  final String? userId = FirebaseAuth.instance.currentUser?.uid;
  if (userId != null) {
    await FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection('Comments')
        .add({
      'text': text,
      'userId': userId,
      'timestamp': FieldValue.serverTimestamp(),
    });

    // You might also want to update the comment count in the main post document
    // For example:
    // FirebaseFirestore.instance.collection('Posts').doc(postId).update({
    //   'commentCount': FieldValue.increment(1),
    // });
  }
}
