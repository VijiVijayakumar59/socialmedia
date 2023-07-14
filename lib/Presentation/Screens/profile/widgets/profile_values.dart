import 'package:flutter/material.dart';

class ProfileFollowing extends StatelessWidget {
  final String value;
  final String titles;
  const ProfileFollowing({
    super.key,
    required this.value,
    required this.titles,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 10.0, right: 8.0, bottom: 8.0, top: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          Text(titles)
        ],
      ),
    );
  }
}
