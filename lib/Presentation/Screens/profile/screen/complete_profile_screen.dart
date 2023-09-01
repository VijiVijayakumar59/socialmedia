import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialmedia/Data/common/colors.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:socialmedia/Data/models/profile_model.dart';
import 'package:socialmedia/Presentation/Screens/home/screen/home.dart';
import '../widgets/edit_widget.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final CollectionReference usersCollection = firestore.collection('Users');

class SetUpProfile extends StatefulWidget {
  final bool isEdit;
  const SetUpProfile({
    Key? key,
    this.isEdit = false,
  }) : super(key: key);

  @override
  State<SetUpProfile> createState() => _SetUpProfileState();
}

TextEditingController nameController = TextEditingController();
TextEditingController professionController = TextEditingController();
TextEditingController locationController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController mailController = TextEditingController();

class _SetUpProfileState extends State<SetUpProfile> {
  final profileKey = GlobalKey<FormState>();
  File? galleryFile;
  String? image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    String id = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: twhitecolor,
        elevation: 0,
        title: const Text("Edit Profile"),
        actions: [
          IconButton(
              onPressed: () {
                if (widget.isEdit) {
                  updateUser(context);
                } else {
                  addUser(context);
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
                    name: "Name"),
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
    FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser?.email)
        .update({"image": image});
    // debugPrint("image uploading:$image");
    return image;
  }

  Future<void> addUser(BuildContext context) async {
    try {
      final userCollection = FirebaseFirestore.instance.collection('Users');
      final String currentUserId = FirebaseAuth.instance.currentUser!.uid;
      final userDocument = userCollection.doc(currentUserId);
      final userDetails = Profile(
        id: FirebaseAuth.instance.currentUser?.uid,
        email: currentUserId,
        image: image,
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
        location: locationController.text.trim(),
        profession: professionController.text.trim(),
        followers: [],
        following: [],
        posts: [],
      );
      await userDocument.set(userDetails.toJson()).then((value) {
        debugPrint("user document added succesfully");
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ));
      });
    } catch (e) {
      debugPrint("error occured while adding user document: $e");
    }
  }

  Future<void> updateUser(BuildContext context) async {
    debugPrint("image:$image");
    try {
      final userCollection = FirebaseFirestore.instance.collection('Users');
      final String currentUserEmail = FirebaseAuth.instance.currentUser!.email!;
      final userDocument = userCollection.doc(currentUserEmail);
      final userDetails = Profile(
        id: FirebaseAuth.instance.currentUser?.uid,
        email: currentUserEmail,
        image: image,
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
        location: locationController.text.trim(),
        profession: professionController.text.trim(),
        followers: [],
        following: [],
        posts: [],
      );
      await userDocument.update(userDetails.toJson()).then((value) {
        debugPrint("user document updated succesfully");
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ));
      });
    } catch (e) {
      debugPrint("error occured while adding user document: $e");
    }
  }
}
