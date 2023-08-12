import 'package:flutter/material.dart';

class FollowState extends ChangeNotifier {
  bool _isFollowing = false;

  bool get isFollowing => _isFollowing;

  void setFollowingState(bool status) {
    _isFollowing = status;
    notifyListeners();
  }
}
