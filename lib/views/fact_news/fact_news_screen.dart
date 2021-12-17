import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/resources/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FactNewsScreen extends StatefulWidget {
  const FactNewsScreen({Key? key}) : super(key: key);

  @override
  _FactNewsScreenState createState() => _FactNewsScreenState();
}

class _FactNewsScreenState extends State<FactNewsScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        SingleChildScrollView(
          child: _buildBody(),
        )
      ],
    );
  }

  Widget _buildHeader() {
    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Text('LỌC TIN TỨC', style: StylesText.content20BoldBlack),
          SizedBox(
            height: 5,
          ),
          Text('Chọn loại tin tức cần lọc',
              style: StylesText.content14BoldGrey),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.transparent,
            ),
            width: 305,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                index == 0
                    ? CustomButton(
                        buttonText: 'TIN THẬT',
                        buttonColor: MyColors.blue,
                        buttonRadius: 30,
                        width: 150,
                        textStyle: StylesText.content14BoldWhite,
                        onPressed: () {
                          setState(() {
                            index = 0;
                          });
                        },
                      )
                    : CustomButton(
                        buttonText: 'TIN THẬT',
                        buttonColor: MyColors.greyLight,
                        buttonRadius: 30,
                        width: 150,
                        textStyle: StylesText.content12BoldWhite,
                        onPressed: () {
                          setState(() {
                            index = 0;
                          });
                        },
                      ),
                index == 1
                    ? CustomButton(
                        buttonText: 'TIN GIẢ',
                        buttonColor: MyColors.blue,
                        buttonRadius: 30,
                        width: 150,
                        textStyle: StylesText.content14BoldWhite,
                        onPressed: () {
                          setState(() {
                            index = 0;
                          });
                        },
                      )
                    : CustomButton(
                        buttonText: 'TIN GIẢ',
                        buttonColor: MyColors.greyLight,
                        buttonRadius: 30,
                        width: 150,
                        textStyle: StylesText.content12BoldWhite,
                        onPressed: () {
                          setState(() {
                            index = 1;
                          });
                        },
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (index == 0) {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[Text('Tin thật')],
        ),
      );
    } else {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[Text('Tin giả')],
        ),
      );
    }
  }
}
