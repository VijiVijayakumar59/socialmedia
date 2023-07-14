import 'package:flutter/material.dart';

import '../../../../Data/common/colors.dart';

class SettingsWidget extends StatelessWidget {
  final String items;
  final IconData icon;
  final VoidCallback? onpressed;
  const SettingsWidget({
    super.key,
    required this.items,
    required this.icon,
    required this.onpressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onpressed,
        style: ElevatedButton.styleFrom(
          splashFactory: NoSplash.splashFactory,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 0,
          side: BorderSide(color: Colors.grey.shade300),
          primary: tgrey2,
          minimumSize: const Size.fromHeight(50), // NEW
        ),
        child: Row(
          children: [
            Icon(icon),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: Text(
                items,
                style: TextStyle(
                  color: tblackcolor,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
