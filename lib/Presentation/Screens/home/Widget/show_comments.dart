import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowComments extends StatelessWidget {
  final String postId;

  const ShowComments({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.clear),
          ),
          title: const Text("Comments"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Posts')
                .doc(postId)
                .collection('Comments')
                .orderBy('timestamp', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              Map<String, String> userIdToUsernameMap = {};
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasData && snapshot.data != null) {
                final List<QueryDocumentSnapshot> commentDocs =
                    snapshot.data!.docs;
                if (commentDocs.isEmpty) {
                  return const Center(
                    child: Text("No comments yet"),
                  );
                }
                return ListView.builder(
                  itemCount: commentDocs.length,
                  itemBuilder: (context, index) {
                    final commentData = commentDocs[index].data() as Map;
                    final String commentText = commentData['text'] as String;
                    final String userId = commentData['userId'] as String;

                    final String username = userIdToUsernameMap[userId] ??
                        "Unknown"; // Get username from map
                    // Fetch the user's username using userId from Firestore
                    return FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('User')
                          .doc(userId)
                          .get(),
                      builder: (context, userSnapshot) {
                        if (userSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (userSnapshot.hasData) {
                          final userData = userSnapshot.data!.data() as Map?;
                          log("User Data: $userData"); // Print user data
                          if (userData != null) {
                            final String username = userData['name'] as String;
                            userIdToUsernameMap[userId] = username;

                            Container(
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
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      // image: AssetImage(
                                      //     'assets/images/post2.jpg'),
                                      image: NetworkImage(''),
                                      //imageUrl![0]
                                    ),
                                  ),
                                ),
                              ),
                            );
                            Column(
                              children: [
                                Text(username),
                                Text(commentText),
                              ],
                            );
                          }
                        }
                        return ListTile(
                          title: Text(commentText),
                          subtitle: Text(username),
                          // No subtitle here when user data is not available
                        );
                      },
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text('No data available.'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
