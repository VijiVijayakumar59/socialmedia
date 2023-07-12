import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../../Data/common/colors.dart';

class TypingWidget extends StatelessWidget {
  const TypingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
        height: 60,
        width: double.infinity,
        color: twhitecolor,
        child: Row(
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: maincolor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(
                  Icons.add,
                  color: twhitecolor,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Write message...",
                    hintStyle: TextStyle(color: Colors.black54),
                    border: InputBorder.none),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            FloatingActionButton(
              onPressed: () {},
              child: const Icon(
                Icons.send,
                color: twhitecolor,
                size: 18,
              ),
              backgroundColor: maincolor,
              elevation: 0,
            ),
          ],
        ),
      ),
    );
  }
}
