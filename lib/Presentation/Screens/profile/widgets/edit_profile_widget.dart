import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialmedia/Presentation/Screens/profile/widgets/edit_widget.dart';

import '../screen/complete_profile_screen.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? galleryFile;
  String? image;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .where("id", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          return Column(
            children: [
              Center(
                child: Stack(children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundImage: NetworkImage(
                      image ??
                          'https://cdn4.iconfinder.com/data/icons/ibrandify-female-user-action-icon/512/19-512.png',
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: -12,
                    child: IconButton(
                      onPressed: () {
                        _showPicker(context: context);
                      },
                      icon: const Icon(
                        Icons.camera_alt,
                        size: 25,
                      ),
                    ),
                  )
                ]),
              ),
              Textfield(
                  controller: nameController,
                  validate: validateName,
                  name: "Name"),
              Textfield(
                  controller: professionController,
                  validate: validateName,
                  name: "Profession"),
              Textfield(
                  controller: locationController,
                  validate: validateName,
                  name: "Location"),
            ],
          );
        },
      ),
    );
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }

    return null;
  }

  void _showPicker({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () async {
                  final pickedFile = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);

                  if (pickedFile == null) {
                    return;
                  } else {
                    File file = File(pickedFile.path);
                    image = await _uploadImage(file);
                    setState(() {});
                  }

                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                },
              ),
              // ListTile(
              //   leading: const Icon(Icons.photo_camera),
              //   title: const Text('Camera'),
              //   onTap: () async {
              //     final pickedFile =
              //         await ImagePicker().pickImage(source: ImageSource.camera);

              //     if (pickedFile == null) {
              //       return;
              //     } else {
              //       File file = File(pickedFile.path);
              //       image = await _uploadImage(file);
              //       setState(() {});
              //     }

              //     // ignore: use_build_context_synchronously
              //     Navigator.of(context).pop();
              //   },
              // ),
            ],
          ),
        );
      },
    );
  }

  Future<String?> _uploadImage(File file) async {
    final firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;
    DateTime now = DateTime.now();
    String timestamp = now.microsecondsSinceEpoch.toString();
    firebase_storage.Reference ref =
        storage.ref().child('profileimages/$timestamp');
    firebase_storage.UploadTask task = ref.putFile(file);
    await task;
    String downloadURL = await ref.getDownloadURL();
    log(downloadURL);
    image = downloadURL;
    FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser?.email)
        .update({"image": image});
    // debugPrint("image uploading:$image");
    return image;
  }
}
