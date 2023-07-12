import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:socialmedia/Data/common/colors.dart';

import '../../message/screen/message.dart';
import '../../post/screen/post.dart';
import '../../profile/screen/profile.dart';
import '../../search.dart/screen/search.dart';
import '../Widget/home_widget.dart';

List<Widget> widgetOptions = <Widget>[
  HomeWidget(),
  SearchScreen(),
  const PostScreen(),
   MessageScreen(),
  const ProfileScreen()
];

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  int selectedIndex = 0;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetOptions[widget.selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: tblackcolor,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: maincolor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 35,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: maincolor,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: maincolor,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle_outline_sharp,
                color: maincolor,
                size: 50,
              ),
              label: "New Post"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.message_rounded,
                color: maincolor,
              ),
              label: "message"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
                color: maincolor,
              ),
              label: "Home"),
        ],
        onTap: (index) {
          log(index.toString());
          setState(() {
            widget.selectedIndex = index;
          });
        },
      ),
    );
  }
}
