import 'package:flutter/material.dart';

import '../resources/utils/image.dart';

class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        child: Image.asset(
          Images.coming_soon,
        ),
      ),
    );
  }
}
