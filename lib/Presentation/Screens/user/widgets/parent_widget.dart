import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia/Presentation/Screens/user/screens/user_profile.dart';
import 'package:socialmedia/provider/follow_state.dart';

class ParentWidget extends StatelessWidget {
  const ParentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FollowState>(
      create: (context) => FollowState(),
      child: const UserProfile(
          name: 'name',
          image: 'image',
          profession: 'profession',
          followers: [],
          following: [],
          email: "email",
          id: "id",
          posts: []),
    );
  }
}
