import 'package:flutter/material.dart';

// FollowState.dart

class FollowState extends ChangeNotifier {
  Map<String, bool> _followStatus = {};

  bool isFollowing(String userId) {
    return _followStatus[userId] ?? false;
  }

  void toggleFollow(String userId) {
    if (_followStatus.containsKey(userId)) {
      _followStatus[userId] = !_followStatus[userId]!;
    } else {
      _followStatus[userId] = true;
    }
    notifyListeners();
  }
}
