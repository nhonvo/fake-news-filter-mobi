import 'package:fake_news/resources/utils/style.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final double width;
  final double? height;
  final TextEditingController controller;
  final VoidCallback? onPressed;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final String hintText;

  const CustomTextField(
      {Key? key,
      required this.width,
      this.height,
      required this.controller,
      this.onPressed,
      required this.prefixIcon,
      this.suffixIcon,
      required this.obscureText,
      required this.hintText})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30.0),
          // ignore: prefer_const_literals_to_create_immutables
          boxShadow: [const BoxShadow(color: Colors.lightBlue, blurRadius: 1.0, spreadRadius: 0.2)]),
      child: TextFormField(
        textAlign: TextAlign.justify,
        obscureText: widget.obscureText,
        controller: widget.controller,
        style: StylesText.content16MediumBlack,
        decoration: InputDecoration(
            hintStyle: StylesText.content14LightBlack,
            hintText: widget.hintText,
            contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(30),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(30),
            )),
      ),
    );
  }
}
