import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialmedia/Data/common/colors.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:socialmedia/Data/models/profile_model.dart';
import '../widgets/edit_widget.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final CollectionReference usersCollection = firestore.collection('users');

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

TextEditingController nameController = TextEditingController();
TextEditingController professionController = TextEditingController();
TextEditingController locationController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController mailController = TextEditingController();

class _EditProfileState extends State<EditProfile> {
  final profileKey = GlobalKey<FormState>();
  File? galleryFile;
  String? image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: twhitecolor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text("Edit Profile"),
        actions: [
          IconButton(
              onPressed: () async {
                if (profileKey.currentState!.validate()) {
                  Profile data = Profile(
                    image: image,
                    name: nameController.text.trim(),
                    phone: int.parse(phoneController.text.trim()),
                    place: locationController.text.trim(),
                    profession: professionController.text.trim(),
                  );
                  await addUser(data, context);
                }
              },
              icon: const Icon(Icons.check_rounded))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: profileKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 14),
                  child: Text(
                    "PUBLIC INFORMATION",
                    style: TextStyle(
                        fontWeight: FontWeight.w700, color: tgreycolor),
                  ),
                ),
                Textfield(
                    controller: nameController,
                    validate: validateName,
                    name: "First Name"),
                Textfield(
                    controller: professionController,
                    validate: validateName,
                    name: "Profession"),
                Textfield(
                    controller: locationController,
                    validate: validateName,
                    name: "Location"),
                Textfield(
                    controller: phoneController,
                    validate: validateName,
                    name: "Phone"),
                Textfield(
                    controller: mailController,
                    validate: validateName,
                    name: "mail"),
              ],
            ),
          ),
        ),
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
    return image;
  }
}

Future<void> addUser(Profile profileModel, BuildContext context) async {
  final user = FirebaseFirestore.instance.collection('User');
  final reference = user.doc();
  final String email = FirebaseAuth.instance.currentUser!.email!;
  try {
    await reference.set({
      'id': reference.id,
      'email': email,
      'image': profileModel.image,
      'name': profileModel.name,
      'phone': profileModel.phone,
      'place': profileModel.place,
      'profession': profileModel.profession,
      'posts': 0,
      'followers': 0,
      'following': 0,
    }).then((value) {
      Navigator.of(context).pop();
    });
  } catch (error) {
    log("Failed to add product: $error");
  }
}
