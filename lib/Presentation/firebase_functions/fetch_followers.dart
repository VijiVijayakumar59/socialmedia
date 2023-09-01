// import 'package:cloud_firestore/cloud_firestore.dart';

// Future<List<Map<String, dynamic>>> fetchFollowers() async {
//   final QuerySnapshot snapshot = await FirebaseFirestore.instance
//       .collection('Users')
//       .where('id', isEqualTo: id) // Replace with the appropriate user ID
//       .get();

//   if (snapshot.docs.isNotEmpty) {
//     final data = snapshot.docs.first.data();
//     return List<Map<String, dynamic>>.from(data['followers']);
//   } else {
//     return []; // Return an empty list if no followers found
//   }
// }
