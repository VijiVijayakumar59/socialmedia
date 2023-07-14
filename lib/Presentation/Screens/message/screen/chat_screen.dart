import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:socialmedia/Data/common/colors.dart';

import '../widget/chat_model.dart';
import '../widget/typing_widget.dart';
import 'message.dart';

class ChatScreen extends StatelessWidget {
  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(
        messageContent: "Hey Kriss, I am doing fine dude. wbu?",
        messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(
        messageContent: "Is there any thing wrong?", messageType: "sender"),
  ];
  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Column(
            children: const [
              Center(
                child: Text(
                  "Username",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "Online",
                style: TextStyle(fontSize: 12, color: maincolor),
              )
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8, top: 4, bottom: 4),
              child: Container(
                height: 40,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle,
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.red, Colors.yellow],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      shape: BoxShape.rectangle,
                      image: const DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/story.jpeg'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.only(
                        left: 14, right: 14, top: 10, bottom: 10),
                    child: Align(
                      alignment: (messages[index].messageType == "receiver"
                          ? Alignment.topLeft
                          : Alignment.topRight),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: (messages[index].messageType == "receiver"
                              ? twhitecolor
                              : torangecolor),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          messages[index].messageContent,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            TypingWidget(),
          ],
        ),
        // bottomNavigationBar: TypingWidget(),
        //bottomSheet: TypingWidget(),
      ),
    );
  }
}
