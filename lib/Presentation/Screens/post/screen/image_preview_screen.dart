import 'package:flutter/material.dart';
import 'package:socialmedia/Presentation/Screens/post/widget/post_details.dart';
import '../../../../Data/common/colors.dart';

class ImagePreviewScreen extends StatelessWidget {
  final String imageUrl;
  const ImagePreviewScreen({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Image Preview",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
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
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PostDetails(
                  imageUrl: imageUrl,
                ),
              ));
            },
          ),
        ],
      ),
      body: Center(
        child: Image.network(imageUrl),
      ),
    );
  }
}
