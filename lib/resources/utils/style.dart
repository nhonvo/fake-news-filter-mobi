import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyColors {
  static const Color blue = Color.fromRGBO(38, 143, 255, 1.0);
  static const Color red = Color.fromRGBO(244, 30, 30, 1.0);
  static const Color green = Color.fromRGBO(31, 207, 108, 1.0);
  static const Color greenDart = Color.fromRGBO(25, 138, 87, 1.0);
  static const Color greenLight = Color.fromRGBO(29, 219, 209, 1.0);
  static const Color greyLight = Color.fromRGBO(223, 223, 223, 1.0);
  static const Color greyLight2 = Color.fromRGBO(210, 210, 210, 1.0);
  static const Color greyDark = Color.fromRGBO(132, 131, 132, 1.0);
  static const Color blueDart = Color.fromRGBO(8, 38, 71, 1.0);
  static const Color blueLight = Color.fromRGBO(236, 252, 255, 0.9);
  static const Color blueEgg = Color.fromRGBO(154, 234, 252, 1.0);

  static const Color yellow = Color.fromRGBO(255, 213, 0, 1.0);
  static const Color orange = Color.fromRGBO(255, 149, 104, 1.0);
  static const Color transbackground = Color.fromARGB(10, 0, 0, 0);
  static const Color trans = Color.fromARGB(90, 0, 0, 0);

  static const Color card1 = Color.fromRGBO(0, 178, 184, 1.0);
  static const Color card1t = Color.fromRGBO(16, 192, 197, 1.0);
}

class SizeText {
  static double queryData = 0.0;
  static double size10 = 10.0 / queryData;
  static double size12 = 12.0 / queryData;
  static double size14 = 14.0 / queryData;
  static double size15 = 15.0 / queryData;
  static double size16 = 16.0 / queryData;
  static double size17 = 17.0 / queryData;
  static double size18 = 18.0 / queryData;
  static double size20 = 20.0 / queryData;
  static double size24 = 24.0 / queryData;
  static double size28 = 28.0 / queryData;
  static double size32 = 32.0 / queryData;
  static double size40 = 40.0 / queryData;
}

class StylesText {
  static TextStyle content12BoldWhite = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: SizeText.size12,
  );

  static TextStyle content12BlackWhite = TextStyle(
    color: Colors.white,
    fontSize: SizeText.size12,
  );
  static TextStyle content14MediumWhite = TextStyle(
    color: Colors.white,
    fontSize: SizeText.size14,
  );
  static TextStyle content12MediumWhite = TextStyle(
    color: Colors.white,
    fontSize: SizeText.size12,
  );
  static TextStyle content14BoldWhite = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: SizeText.size14,
  );
  static TextStyle content16BoldWhite = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: SizeText.size16,
  );
  static TextStyle content17BoldWhite = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: SizeText.size17,
  );
  static TextStyle content18BoldWhite = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: SizeText.size18,
  );

  static TextStyle content10BoldRed = TextStyle(
    color: MyColors.red,
    fontWeight: FontWeight.bold,
    fontSize: SizeText.size10,
  );
  static TextStyle content10BoldBlack = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: SizeText.size10,
  );

  static TextStyle content10MediumBlack = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w400,
    fontSize: SizeText.size10,
  );
  static TextStyle content10BoldBlue = TextStyle(
    color: MyColors.blue,
    fontWeight: FontWeight.bold,
    fontSize: SizeText.size10,
  );

  static TextStyle content12BoldBlue = TextStyle(
    color: Colors.blue,
    fontWeight: FontWeight.bold,
    fontSize: SizeText.size12,
  );

  static TextStyle content12MediumBlack = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w400,
    fontSize: SizeText.size12,
  );
  static TextStyle content12MediumBlue = TextStyle(
    color: MyColors.blue,
    fontWeight: FontWeight.w400,
    fontSize: SizeText.size12,
  );
  static TextStyle content12LightBlack = TextStyle(
    color: Colors.black,
    fontFamily: 'SF-UI-LIGHT',
    fontSize: SizeText.size12,
  );

  static TextStyle content12BoldOrange = TextStyle(
    color: const Color.fromRGBO(255, 140, 0, 1),
    fontWeight: FontWeight.bold,
    fontSize: SizeText.size12,
  );
  static TextStyle content14LightBlack = TextStyle(
    color: Colors.black,
    fontFamily: 'SF-UI-LIGHT',
    fontSize: SizeText.size14,
  );
  static TextStyle content14MediumBlack = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w400,
    fontSize: SizeText.size14,
  );

  static TextStyle content14MediumGrey = TextStyle(
    color: const Color.fromRGBO(216, 216, 216, 1.0),
    fontWeight: FontWeight.w400,
    fontSize: SizeText.size14,
  );

  static TextStyle content12BoldGrey = TextStyle(
    color: MyColors.greyDark,
    fontWeight: FontWeight.bold,
    fontSize: SizeText.size12,
  );

  static TextStyle content14BoldGrey = TextStyle(
    color: MyColors.greyDark,
    fontWeight: FontWeight.bold,
    fontSize: SizeText.size14,
  );

  static TextStyle content14MediumBlue = TextStyle(
    color: MyColors.blue,
    fontWeight: FontWeight.w400,
    fontSize: SizeText.size14,
  );
  static TextStyle content13SemiBlack = TextStyle(
    color: Colors.black,
    fontFamily: 'SF-UI-SEMIBOLD',
    fontSize: SizeText.size14,
  );
  static TextStyle content13HeavyBlack = TextStyle(
    color: Colors.black,
    fontFamily: 'SF-UI-HEAVY',
    fontSize: SizeText.size14,
  );
  static TextStyle content12BoldBlack = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: SizeText.size12,
  );
  static TextStyle content14BoldBlack = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: SizeText.size14,
  );
  static TextStyle content14BoldOrange = TextStyle(
    color: MyColors.orange,
    fontWeight: FontWeight.bold,
    fontSize: SizeText.size14,
  );
  static TextStyle content16BoldOrange = TextStyle(
    color: MyColors.orange,
    fontWeight: FontWeight.bold,
    fontSize: SizeText.size16,
  );
  static TextStyle content14BoldBlue = TextStyle(
    color: MyColors.blue,
    fontWeight: FontWeight.bold,
    fontSize: SizeText.size14,
  );

  static TextStyle content16BoldBlue = TextStyle(
    color: Colors.blue,
    fontWeight: FontWeight.bold,
    fontSize: SizeText.size16,
  );

  static TextStyle content17BoldBlue = TextStyle(
    color: Colors.blue,
    fontWeight: FontWeight.bold,
    fontSize: SizeText.size17,
  );
  static TextStyle content16LightBlack = TextStyle(
    color: Colors.black,
    fontFamily: 'SF-UI-LIGHT',
    fontSize: SizeText.size16,
  );
  static TextStyle content16BoldBlack = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: SizeText.size16,
  );
  static TextStyle content16HeavyYellow = TextStyle(
    color: MyColors.yellow,
    fontFamily: 'SF-UI-HEAVY',
    fontSize: SizeText.size16,
  );
  static TextStyle content16BoldRed = TextStyle(
    color: MyColors.red,
    fontWeight: FontWeight.bold,
    fontSize: SizeText.size16,
  );

  static TextStyle content16BoldBlueLight = TextStyle(
    color: const Color.fromRGBO(29, 219, 209, 1.0),
    fontWeight: FontWeight.bold,
    fontSize: SizeText.size16,
  );
  static TextStyle content16RegularBlack = TextStyle(
    color: Colors.black,
    fontFamily: 'SF-UI-REGULAR',
    fontSize: SizeText.size16,
  );
  static TextStyle content14BoldItalicBlack = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
    fontSize: SizeText.size14,
  );

  static TextStyle content16MediumBlack = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w400,
    fontSize: SizeText.size16,
  );
  static TextStyle content16MediumBlue = TextStyle(
    color: MyColors.blue,
    fontWeight: FontWeight.w400,
    fontSize: SizeText.size16,
  );

  static TextStyle content18HeavyBlack = TextStyle(
    color: Colors.black,
    fontFamily: 'SF-UI-HEAVY',
    fontSize: SizeText.size18,
  );
  static TextStyle content18BoldBlack = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: SizeText.size18,
  );
  static TextStyle content20BoldBlack = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: SizeText.size20,
  );
  static TextStyle title24BoldBlack = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: SizeText.size24,
  );
  static TextStyle title24HeavyBlack = TextStyle(
    color: Colors.black,
    fontFamily: 'SF-UI-HEAVY',
    fontSize: SizeText.size24,
  );
  static TextStyle content24BoldOrange = TextStyle(
    color: MyColors.orange,
    fontWeight: FontWeight.bold,
    fontSize: SizeText.size24,
  );
}
