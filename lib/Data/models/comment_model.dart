import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Comments {
  final String? text;
  final Timestamp? timeStamp;
  final Reference? userId;

  Comments.fromJson(Map<String, Object?> json)
      : this(
          text: json['text']! as String,
          timeStamp: json['timeStamp']! as Timestamp,
          userId: json['userId']! as Reference,
        );
  Comments({
    required this.text,
    required this.timeStamp,
    required this.userId,
  });
}
