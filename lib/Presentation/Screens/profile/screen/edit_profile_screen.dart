import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialmedia/Data/common/colors.dart';

import '../widgets/edit_widget.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? galleryFile;
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
          IconButton(onPressed: () {}, icon: const Icon(Icons.check_rounded))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundImage: galleryFile == null
                        ? const AssetImage("assets/images/storyprofile.jpeg")
                        : FileImage(
                            File(galleryFile!.path),
                          ) as ImageProvider,
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
                  style:
                      TextStyle(fontWeight: FontWeight.w700, color: tgreycolor),
                ),
              ),
              const Textfield(name: "First Name"),
              const Textfield(name: "Last Name"),
              const Textfield(name: "Location"),
              const Textfield(name: "Phone"),
              const Textfield(name: "mail"),
            ],
          ),
        ),
      ),
    );
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
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future getImage(
    ImageSource img,
  ) async {
    final pickedFile = await picker.pickImage(source: img);
    XFile? xfilePick = pickedFile;
    setState(
      () {
        if (xfilePick != null) {
          galleryFile = File(pickedFile!.path);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }
}
