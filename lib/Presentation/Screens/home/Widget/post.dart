import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:socialmedia/Data/common/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
              leading: Container(
                width: 48,
                height: 48,
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
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      shape: BoxShape.rectangle,
                      image: const DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/post2.jpg'),
                      ),
                    ),
                  ),
                ),
              ),
              title: const Text(
                "Username",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: const Text("Los Angeles, California"),
              trailing: const Icon(Icons.more_vert_rounded),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 2, right: 8),
              child: Container(
                height: 300,
                // width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/post4.jpeg"),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Wrap(
                spacing: 10,
                children: [
                  const Icon(
                    Icons.favorite,
                    size: 32,
                    color: maincolor,
                  ),
                  SvgPicture.asset(
                    "assets/images/comment.svg",
                    width: 33,
                  ),
                  SvgPicture.asset(
                    "assets/images/share.svg",
                    width: 28,
                  )
                ],
              ),
              trailing: Icon(
                Icons.bookmark_border_outlined,
                size: 28,
                color: tblackcolor,
              ),
            ),
            Row(children: const [
              Padding(
                padding: EdgeInsets.only(left: 18.0),
                child: Text(
                  "1000 likes",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ]),
            Row(children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18),
                child: Container(
                  width: 350,
                  child: const Text(
                    "Had the best nights with you guys!!Had the best nights with you guys!!Had the best nights with you guys!!",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ]),
            ListTile(
              leading: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/post2.jpg'),
                    )),
              ),
              title: TextFormField(
                textAlign: TextAlign.start,
                cursorColor: tblackcolor,
                cursorHeight: 18,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Add a comment",
                    labelStyle: TextStyle(
                      color: tblackcolor,
                    )),
              ),
              trailing: Wrap(
                spacing: 10,
                children: [
                  TextButton(
                    style: const ButtonStyle(),
                    onPressed: () {},
                    child: const Text("post"),
                  ),
                  const Icon(
                    Icons.favorite,
                    size: 18,
                    color: maincolor,
                  ),
                  const Icon(
                    Icons.add_circle_outline,
                    size: 18,
                    color: maincolor,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
