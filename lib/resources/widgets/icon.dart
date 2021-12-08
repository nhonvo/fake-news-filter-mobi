import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  final Color? colorbackground;
  final Color? coloricon;
  final IconData iconData;
  final double? radius;
  final double? sizeicon;
  CustomIcon(
      {this.colorbackground,
      this.coloricon,
      required this.iconData,
      this.radius,
      this.sizeicon});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: colorbackground,
      radius: radius,
      child: Center(
        child: Icon(
          iconData,
          color: coloricon,
          size: sizeicon,
        ),
      ),
    );
  }
}
