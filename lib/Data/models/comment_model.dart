import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Comments {
  final String? text;
  final Timestamp? timeStamp;
  final Reference? userId;
  final String? username;

  Comments.fromJson(Map<String, Object?> json)
      : this(
          text: json['text']! as String,
          timeStamp: json['timeStamp']! as Timestamp,
          userId: json['userId']! as Reference,
          username: json['username']! as String,
        );
  Comments({
    required this.text,
    required this.timeStamp,
    required this.userId,
    required this.username,
  });
}
