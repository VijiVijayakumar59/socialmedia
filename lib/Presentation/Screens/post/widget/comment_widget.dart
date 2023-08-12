// import 'package:flutter/material.dart';

// class CommentPage extends StatelessWidget {
//   final String postId; // The ID of the post

//   CommentPage({required this.postId});

//   @override
//   Widget build(BuildContext context) {
//     // Implement the UI to display comments here
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Comments'),
//         ),
//         body: Center(
//           child: Text('No comments'),
//         ),
//       ),
//     );
//   }
// }


// // ignore_for_file: unused_local_variable

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:socialmedia/Data/common/colors.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import '../../../post_functions/post_functions.dart';

// class PostWidget extends StatefulWidget {
//   const PostWidget({
//     super.key,
//   });

//   @override
//   State<PostWidget> createState() => _PostWidgetState();
// }

// class _PostWidgetState extends State<PostWidget> {
//   bool isLiked = false;

//   // void toggleLikeStatus(DocumentSnapshot postDocument) async {
//   //   final user = FirebaseAuth.instance.currentUser;
//   //   if (user != null) {
//   //     final postId = postDocument.id;
//   //     final likedBy = postDocument['likedBy'] as List<dynamic>;

//   //     if (likedBy.contains(user.uid)) {
//   //       // User already liked, remove the like
//   //       await FirebaseFirestore.instance
//   //           .collection('Posts')
//   //           .doc(postId)
//   //           .update({
//   //         'likes': FieldValue.increment(-1),
//   //         'likedBy': FieldValue.arrayRemove([user.uid]),
//   //       });
//   //     } else {
//   //       // User not liked, add the like
//   //       await FirebaseFirestore.instance
//   //           .collection('Posts')
//   //           .doc(postId)
//   //           .update({
//   //         'likes': FieldValue.increment(1),
//   //         'likedBy': FieldValue.arrayUnion([user.uid]),
//   //       });
//   //     }
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     final String? userId = FirebaseAuth.instance.currentUser?.uid;
//     String? email = FirebaseAuth.instance.currentUser?.email;

//     return StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('Posts').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const CircularProgressIndicator();
//           } else if (snapshot.hasData && snapshot.data != null) {
//             final List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

//             return ListView.builder(
//               itemCount: documents.length,
//               itemBuilder: (context, index) {
//                 final document = documents[index];
//                 final name = document['username'] as String;
//                 final imageUrl = document['postImage'] as String?;
//                 final location = document['location'] as String?;
//                 final likes = document['likes'].toString();
//                 final description = document['description'] as String?;
//                 final likedBy =
//                     (document['likedBy'] as List<dynamic>).cast<String>();
//                 final postId = document.id;

//                 final imageUrlValue = imageUrl ?? '';
//                 final locationValue = location ?? '';
//                 final likesValue = likes ?? '0';
//                 final descriptionValue = description ?? '';
//                 return StreamBuilder<QuerySnapshot>(
//                     stream: FirebaseFirestore.instance
//                         .collection('User')
//                         .snapshots(),
//                     builder: (context, snapshot) {
//                       if (snapshot.hasData) {
//                         final List<DocumentSnapshot> documents =
//                             snapshot.data!.docs;
//                         return documents.isNotEmpty
//                             ? Column(
//                                 children: [
//                                   ListTile(
//                                     leading: Container(
//                                       width: 48,
//                                       height: 48,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         shape: BoxShape.rectangle,
//                                         gradient: const LinearGradient(
//                                           begin: Alignment.topCenter,
//                                           end: Alignment.bottomCenter,
//                                           colors: [Colors.red, Colors.yellow],
//                                         ),
//                                       ),
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(4.0),
//                                         child: Container(
//                                           width: 60,
//                                           height: 60,
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             shape: BoxShape.rectangle,
//                                             image: DecorationImage(
//                                               fit: BoxFit.cover,
//                                               // image: AssetImage(
//                                               //     'assets/images/post2.jpg'),
//                                               image: NetworkImage(
//                                                 documents[0].get(
//                                                   'image',
//                                                 ),
//                                                 //imageUrl![0]
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     title: Text(name),
//                                     subtitle: Text(
//                                       location ?? '',
//                                       style: const TextStyle(
//                                           fontWeight: FontWeight.w600),
//                                     ),
//                                     // trailing: IconButton(
//                                     //     onPressed: () {
//                                     //     },
//                                     //     icon: const Icon(
//                                     //       Icons.more_vert_rounded,
//                                     //     ),
//                                     // ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                         left: 8, top: 2, right: 8),
//                                     child: Container(
//                                       height: 400,
//                                       // width: double.infinity,
//                                       decoration: BoxDecoration(
//                                         image: DecorationImage(
//                                           fit: BoxFit.fill,
//                                           // image: AssetImage("assets/images/post4.jpeg"),
//                                           image: NetworkImage(
//                                             imageUrl ?? '',
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   // kheight20,
//                                   ListTile(
//                                     leading: Wrap(
//                                       spacing: 10,
//                                       children: [
//                                         IconButton(
//                                           onPressed: () async {
//                                             if (userId != null) {
//                                               final isLiked =
//                                                   likedBy.contains(userId);

//                                               if (isLiked) {
//                                                 // User has already liked, remove the like
//                                                 await FirebaseFirestore.instance
//                                                     .collection('Posts')
//                                                     .doc(postId)
//                                                     .update({
//                                                   'likes':
//                                                       FieldValue.increment(-1),
//                                                   'likedBy':
//                                                       FieldValue.arrayRemove(
//                                                           [userId]),
//                                                 });
//                                               } else {
//                                                 // User has not liked, add the like
//                                                 await FirebaseFirestore.instance
//                                                     .collection('Posts')
//                                                     .doc(postId)
//                                                     .update({
//                                                   'likes':
//                                                       FieldValue.increment(1),
//                                                   'likedBy':
//                                                       FieldValue.arrayUnion(
//                                                           [userId]),
//                                                 });
//                                               }
//                                             }
//                                           },
//                                           icon: Icon(
//                                             likedBy.contains(userId)
//                                                 ? Icons.favorite
//                                                 : Icons.favorite_border,
//                                             size: 32,
//                                             color: likedBy.contains(userId)
//                                                 ? maincolor
//                                                 : Colors.grey,
//                                           ),
//                                         ),
//                                         InkWell(
//                                           onTap: () {
//                                             showCommentBottomSheet(
//                                                 context, postId);
//                                           },
//                                           child: SvgPicture.asset(
//                                             "assets/images/comment.svg",
//                                             width: 33,
//                                           ),
//                                         ),
//                                         SvgPicture.asset(
//                                           "assets/images/share.svg",
//                                           width: 28,
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                   Row(children: [
//                                     Padding(
//                                       padding:
//                                           const EdgeInsets.only(left: 18.0),
//                                       child: Text(
//                                         likes,
//                                         style: const TextStyle(
//                                             fontWeight: FontWeight.w700),
//                                       ),
//                                     ),
//                                   ]),
//                                   Row(children: [
//                                     Padding(
//                                       padding: const EdgeInsets.only(
//                                           left: 18.0, right: 18),
//                                       child: Container(
//                                         // width: 350,
//                                         width:
//                                             MediaQuery.of(context).size.width *
//                                                 0.9,
//                                         child: Text(
//                                           description!,
//                                           maxLines: 2,
//                                           overflow: TextOverflow.ellipsis,
//                                           style: const TextStyle(
//                                             fontWeight: FontWeight.w700,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ]),
//                                 ],
//                               )
//                             : Column(
//                                 children: const [
//                                   Center(
//                                     child: Text("No posts yet"),
//                                   ),
//                                 ],
//                               );
//                       }
//                       return const CircularProgressIndicator();
//                     });
//               },
//             );
//           } else {
//             return const CircularProgressIndicator();
//           }
//         });
//   }
// }
