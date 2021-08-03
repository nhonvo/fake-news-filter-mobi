import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomButton extends StatefulWidget {
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback? onPressed;
  final double buttonRadius;
  final double? width, height;

  const CustomButton(
      {Key? key,
      required this.buttonText,
      required this.buttonColor,
      required this.textColor,
      this.onPressed,
      required this.buttonRadius,
      this.width,
      this.height})
      : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        width: widget.width,
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.all(Radius.circular(widget.buttonRadius)),
            color: widget.buttonColor),
        child: Text(
          widget.buttonText,
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ));
  }
}
