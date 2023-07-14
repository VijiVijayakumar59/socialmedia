import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:socialmedia/Data/common/colors.dart';

import '../../message/screen/message.dart';
import '../../post/screen/post.dart';
import '../../profile/screen/profile.dart';
import '../../search/screen/search.dart';
import '../Widget/home_widget.dart';

List<Widget> widgetOptions = <Widget>[
  const HomeWidget(),
  SearchScreen(),
  const PostScreen(),
  MessageScreen(),
  const ProfileScreen()
];

// ignore: must_be_immutable
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
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          primaryColor: maincolor,
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: tgreycolor,
          elevation: 0,
          iconSize: 35,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: "Home"),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
              ),
              label: "Search",
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_circle_outline_sharp,
                  size: 50,
                ),
                label: "New Post"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.message_rounded,
                ),
                label: "message"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_circle,
                ),
                label: "Account"),
          ],
          currentIndex: widget.selectedIndex,
          onTap: (index) {
            log(index.toString());
            setState(() {
              widget.selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
