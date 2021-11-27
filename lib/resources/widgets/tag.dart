import 'package:fake_news/resources/utils/style.dart';
import 'package:flutter/material.dart';

class TagTopic extends StatefulWidget {
  final String? tagName;
  final Color buttonColor;
  final VoidCallback? onPressed;

  const TagTopic({
    Key? key,
    required this.tagName,
    required this.buttonColor,
    this.onPressed,
  }) : super(key: key);

  @override
  _TagTopicState createState() => _TagTopicState();
}

class _TagTopicState extends State<TagTopic> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        decoration: BoxDecoration(color: widget.buttonColor, borderRadius: const BorderRadius.all(Radius.circular(15))),
        child: Text(
          widget.tagName.toString(),
          style: StylesText.content14BoldWhite,
        ));
  }
}
