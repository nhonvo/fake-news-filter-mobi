import 'package:fake_news/resources/utils/dimension.dart';
import 'package:fake_news/resources/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WidgetResource extends StatefulWidget {
  const WidgetResource({Key? key}) : super(key: key);

  @override
  _WidgetResourceState createState() => _WidgetResourceState();
}

class _WidgetResourceState extends State<WidgetResource> {
  @override
  Widget build(BuildContext context) {
    Dimension.height = MediaQuery.of(context).size.height;
    Dimension.width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              width: Dimension.getWidth(0.5),
              height: 37,
              buttonText: "Login",
              buttonColor: const Color(0xff082647),
              buttonRadius: 18.5,
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
