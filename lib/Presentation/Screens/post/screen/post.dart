// import 'dart:developer';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:socialmedia/Data/common/colors.dart';

// enum AppState {
//   free,
//   picked,
//   cropped,
// }

// class PostScreen extends StatefulWidget {
//   const PostScreen({super.key});

//   @override
//   State<PostScreen> createState() => _PostScreenState();
// }

// class _PostScreenState extends State<PostScreen> {
//   late AppState state;
//   File? imageFile;

//   @override
//   void initState() {
//     super.initState();
//     state = AppState.free;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//             icon: const Icon(Icons.clear),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//           title: const Text(
//             "New Post",
//             style: TextStyle(fontWeight: FontWeight.w700),
//           ),
//         ),
//         // floatingActionButton: FloatingActionButton(
//         //   backgroundColor: torangecolor,
//         //   elevation: 0,
//         //   onPressed: () {
//         //     pickImage();
//         //     // if (state == AppState.free) {
//         //     //   pickImage();
//         //     // } else if (state == AppState.picked) {
//         //     //   cropImage();
//         //     // } else if (state == AppState.cropped) {
//         //     //   //clearImage();
//         //     //   log("ddv");
//         //     // }
//         //   },
//         //   // child: buildButtonIcon(),
//         // ),
//         // const Text(
//         //   "Select Image",
//         //   style: TextStyle(
//         //     fontSize: 18,
//         //     fontWeight: FontWeight.bold,
//         //   ),
//         // ),

//         // body: Container(
//         //   height: 50,
//         //   width: 50,
//         //   child: Center(
//         //     child:
//         //         imageFile != null ? Image.file(imageFile!) : const SizedBox(),
//         //   ),
//         // ),
//       ),
//     );
//   }

//   // Widget buildButtonIcon() {
//   //   if (state == AppState.free) {
//   //     return const Icon(Icons.add);
//   //   } else if (state == AppState.picked) {
//   //     return const Icon(Icons.crop);
//   //   } else if (state == AppState.cropped) {
//   //     return const Icon(Icons.clear);
//   //   } else {
//   //     return const SizedBox();
//   //   }
//   // }

//   Future pickImage() async {
//     final pickedImage = await ImagePicker().pickImage(
//       source: ImageSource.gallery,
//     );
//     imageFile = pickedImage != null ? File(pickedImage.path) : null;
//     if (imageFile != null) {
//       setState(() {
//         state = AppState.picked;
//       });
//     }
//   }

//   // Future cropImage() async {
//   //   File? croppedFile = (await ImageCropper().cropImage(
//   //     sourcePath: imageFile!.path,
//   //     aspectRatioPresets: [
//   //       CropAspectRatioPreset.square,
//   //       CropAspectRatioPreset.ratio3x2,
//   //       CropAspectRatioPreset.original,
//   //       CropAspectRatioPreset.ratio4x3,
//   //       CropAspectRatioPreset.ratio16x9
//   //     ],
//   //     uiSettings: [
//   //       AndroidUiSettings(
//   //           toolbarTitle: 'Cropper',
//   //           toolbarColor: Colors.deepOrange,
//   //           toolbarWidgetColor: Colors.white,
//   //           initAspectRatio: CropAspectRatioPreset.original,
//   //           lockAspectRatio: false),
//   //       IOSUiSettings(
//   //         title: 'Cropper',
//   //       ),
//   //       WebUiSettings(
//   //         context: context,
//   //       ),
//   //     ],
//   //   )) as File?;
//   //   if (croppedFile != null) {
//   //     setState(() {
//   //       state = AppState.cropped;
//   //       imageFile = croppedFile;
//   //     });
//   //   }
//   // }

//   // void clearImage() {
//   //   imageFile = null;
//   //   setState(() {
//   //     state = AppState.free;
//   //   });
//   // }
// }
