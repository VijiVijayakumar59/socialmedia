import 'package:flutter/material.dart';
import 'package:pandabar/main.view.dart';
import 'package:pandabar/model.dart';
import 'package:socialmedia/Data/common/colors.dart';

import '../../message/screen/message.dart';
import '../../post/screen/post.dart';
import '../../profile/screen/profile.dart';
import '../../search/screen/search.dart';
import '../Widget/home_widget.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String page = 'Grey';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          switch (page) {
            case 'Grey':
              return const HomeWidget();
            case 'Blue':
              return SearchScreen();

            case 'Red':
              return MessageScreen();
            case 'Yellow':
              return const ProfileScreen();

            default:
              return const ProfileScreen();
          }
        },
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          primaryColor: maincolor,
        ),
        child: PandaBar(
          fabIcon: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: ((context) => const PostScreen()),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
          buttonSelectedColor: maincolor,
          backgroundColor: twhitecolor,
          buttonData: [
            PandaBarButtonData(
              id: 'Grey',
              icon: Icons.home,
              title: 'Home',
            ),
            PandaBarButtonData(
              id: 'Blue',
              icon: Icons.search,
              title: 'Search',
            ),
            PandaBarButtonData(
              id: 'Red',
              icon: Icons.message_rounded,
              title: 'Chats',
            ),
            PandaBarButtonData(
              id: 'Yellow',
              icon: Icons.account_circle,
              title: 'Account',
            ),
          ],
          onChange: (id) {
            setState(() {
              page = id;
            });
          },
          onFabButtonPressed: () {},
        ),
      ),
    );
  }
}

// BottomNavigationBar(
//           type: BottomNavigationBarType.fixed,
//           selectedItemColor: Theme.of(context).primaryColor,
//           unselectedItemColor: tgreycolor,
//           elevation: 0,
//           iconSize: 35,
//           items: const [
//             BottomNavigationBarItem(
//                 icon: Icon(
//                   Icons.home,
//                 ),
//                 label: "Home"),
//             BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.search,
//               ),
//               label: "Search",
//             ),
//             BottomNavigationBarItem(
//                 icon: Icon(
//                   Icons.add_circle_outline_sharp,
//                   size: 50,
//                 ),
//                 label: "New Post"),
//             BottomNavigationBarItem(
//                 icon: Icon(
//                   Icons.message_rounded,
//                 ),
//                 label: "message"),
//             BottomNavigationBarItem(
//                 icon: Icon(
//                   Icons.account_circle,
//                 ),
//                 label: "Account"),
//           ],
//           currentIndex: widget.selectedIndex,
//           onTap: (index) {
//             log(index.toString());
//             setState(() {
//               widget.selectedIndex = index;
//             });
//           },
//         ),