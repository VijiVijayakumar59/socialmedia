// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pandabar/main.view.dart';
import 'package:pandabar/model.dart';
import 'package:socialmedia/Data/common/colors.dart';
import 'package:socialmedia/Presentation/Screens/post/screen/image_preview_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../message/screen/message.dart';
import '../../profile/screen/profile.dart';
import '../../search/screen/search.dart';
import '../Widget/home_widget.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final CollectionReference postsCollection = firestore.collection('Posts');

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? image;
  File? imageFile;
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
              return const SearchScreen();

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
            onPressed: () async {
              await pickImage();
              if (image != null) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) => ImagePreviewScreen(
                      
                          imageUrl: image!,
                        )),
                  ),
                );
              }
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

  Future pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      return;
    } else {
      File file = File(pickedFile.path);
      image = await _uploadImage(file);
      setState(() {});
    }
  }

  Future<String?> _uploadImage(File file) async {
    final firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;
    DateTime now = DateTime.now();
    String timestamp = now.microsecondsSinceEpoch.toString();
    firebase_storage.Reference ref = storage.ref().child('Posts/$timestamp');
    firebase_storage.UploadTask task = ref.putFile(file);
    await task;
    String downloadURL = await ref.getDownloadURL();
    log(downloadURL);
    image = downloadURL;
    return image;
  }
}

