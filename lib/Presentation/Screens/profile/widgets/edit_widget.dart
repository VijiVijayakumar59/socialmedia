import 'package:flutter/material.dart';

import '../../../../Data/common/colors.dart';

class Textfield extends StatelessWidget {
  final String name;
  final String? Function(String?)? validate;
  final TextEditingController? controller;
  const Textfield({
    super.key,
    required this.name,
    required this.validate,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        validator: validate,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: maincolor),
            borderRadius: BorderRadius.circular(15.0),
          ),

          hintText: name,
          // suffixIcon: const Icon(
          //   Icons.check_rounded,
          //   color: Colors.green,
          // ),
          filled: true,
          fillColor: twhitecolor,
          isDense: true, // Added this
          contentPadding: const EdgeInsets.all(18),
        ),
      ),
    );
  }
}
