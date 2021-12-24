// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class CustomButton extends StatefulWidget {
  final String buttonText;
  final TextStyle textStyle;
  final Color? buttonColor;
  final VoidCallback? onPressed;
  final double buttonRadius;
  final double width, height;

  const CustomButton({
    Key? key,
    required this.buttonText,
    required this.textStyle,
    this.buttonColor,
    this.onPressed,
    required this.buttonRadius,
    this.width = 10.0,
    this.height = 10.0,
  }) : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: ElevatedButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
                EdgeInsets.only(top: widget.height, bottom: widget.height)),
            backgroundColor: MaterialStateProperty.all(widget.buttonColor),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(widget.buttonRadius), // <-- Radius
            )),
          ),
          onPressed: widget.onPressed,
          child: Text(
            (widget.buttonText).tr,
            style: widget.textStyle,
            textAlign: TextAlign.center,
          )),
    );
  }
}

class CustomIconButton extends StatefulWidget {
  final String? buttonText;
  final Widget icon;
  final TextStyle? textStyle;
  final Color buttonColor;
  final VoidCallback? onPressed;
  final double buttonRadius;
  final double? width, height;

  const CustomIconButton(
      {Key? key,
      this.buttonText,
      required this.icon,
      this.textStyle,
      required this.buttonColor,
      required this.onPressed,
      required this.buttonRadius,
      this.width,
      this.height = 0.0})
      : super(key: key);

  @override
  _CustomIconButtonState createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: TextButton.icon(
          icon: widget.icon,
          label: Text(
            (widget.buttonText)!.tr,
            style: widget.textStyle,
            textAlign: TextAlign.center,
          ),
          onPressed: widget.onPressed,
          style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.all(5)),
            backgroundColor: MaterialStateProperty.all(widget.buttonColor),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(widget.buttonRadius), // <-- Radius
            )),
          )),
    );
  }
}
