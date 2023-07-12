import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:socialmedia/Data/common/colors.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {},
          ),
          title: const Text(
            "New Post",
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          actions: [
            TextButton(
              child: Text(
                "Next",
                style: TextStyle(
                  color: tblackcolor,
                  fontWeight: FontWeight.w900,
                ),
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 360,
                      width: 380,
                      color: tblackcolor,
                    ),
                    Row(
                      children: [
                        Text(
                          "Recent",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_drop_down_outlined))
                      ],
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
