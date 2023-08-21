import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  String? image;
  String name = '';
  String profession = '';
  String location = '';
  String phone = '';
  String mail = '';

  void updateProfile({
    String? image,
    String name = '',
    String profession = '',
    String location = '',
    String phone = '',
    String mail = '',
  }) {
    this.image = image;
    this.name = name;
    this.profession = profession;
    this.location = location;
    this.phone = phone;
    this.mail = mail;

    notifyListeners();
  }
}
