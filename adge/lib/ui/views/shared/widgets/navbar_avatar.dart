import 'package:flutter/material.dart';

class NavbarAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        child: Image(image: AssetImage('no-image.jpg')),
        width: 30,
        height: 30,
      ),
    );
  }
}
