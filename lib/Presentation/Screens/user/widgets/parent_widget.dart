import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia/Presentation/Screens/authentication/screen/sign_up.dart';
import 'package:socialmedia/Presentation/Screens/profile/screen/edit_profile_screen.dart';
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
          followers: 0,
          following: 0,
          email: "email",
          id: "id",
          posts: 0),
    );
  }
}
