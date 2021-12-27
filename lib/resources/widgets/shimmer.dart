import 'package:flutter/material.dart';

const List<Color> defaultColors = [
  Color.fromRGBO(0, 0, 0, 0.1),
  Color(0x44CCCCCC),
  Color.fromRGBO(0, 0, 0, 0.1)
];

class NewsShimmer extends StatefulWidget {
  final bool isRectBox;
  final bool isDarkMode;
  final bool isPurplishMode;
  final AlignmentGeometry beginAlign;
  final AlignmentGeometry endAlign;
  final bool hasBottomBox;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final bool hasCustomColors;
  final List<Color> colors;
  final Color bgColor;
  const NewsShimmer({
    Key? key,
    this.isRectBox = false,
    this.isDarkMode = false,
    this.beginAlign = Alignment.topLeft,
    this.endAlign = Alignment.bottomRight,
    this.hasBottomBox = false,
    this.padding = const EdgeInsets.all(5.0),
    this.margin = const EdgeInsets.all(5.0),
    this.isPurplishMode = false,
    this.hasCustomColors = false,
    this.colors = defaultColors,
    this.bgColor = Colors.transparent,
  }) : super(key: key);
  @override
  _NewsShimmerState createState() => _NewsShimmerState();
}

class _NewsShimmerState extends State<NewsShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  // ****************************init*************************
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this)
          ..repeat();
    _animation = Tween<double>(begin: -2, end: 2).animate(CurvedAnimation(
        curve: Curves.easeInOutSine, parent: _animationController));
  }
  // ****************************init*************************

  // *****************************dispose************************
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // *****************************dispose************************
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return Container(
          margin: widget.margin,
          padding: widget.padding,
          color: widget.isDarkMode ? Color(0xFF0B0B0B) : widget.bgColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildButtomBox(_animation,
                      height: width,
                      width: width,
                      isPurplishMode: widget.isPurplishMode,
                      isDarkMode: widget.isDarkMode,
                      isRectBox: true,
                      beginAlign: widget.beginAlign,
                      endAlign: widget.endAlign,
                      isVideoShimmer: true,
                      hasCustomColors: widget.hasCustomColors,
                      colors: widget.colors.length == 3
                          ? widget.colors
                          : defaultColors),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: width * 0.1,
                        width: width * 0.1,
                        decoration: customBoxDecoration(
                            animation: _animation,
                            isRectBox: widget.isRectBox,
                            isPurplishMode: widget.isPurplishMode,
                            isDarkMode: widget.isDarkMode,
                            hasCustomColors: widget.hasCustomColors,
                            colors: widget.colors.length == 3
                                ? widget.colors
                                : defaultColors),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            height: width * 0.02,
                            width: width * 0.6,
                            decoration: radiusBoxDecoration(
                                animation: _animation,
                                isPurplishMode: widget.isPurplishMode,
                                isDarkMode: widget.isDarkMode,
                                hasCustomColors: widget.hasCustomColors,
                                colors: widget.colors.length == 3
                                    ? widget.colors
                                    : defaultColors),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: width * 0.02,
                            width: width * 0.6,
                            decoration: radiusBoxDecoration(
                                animation: _animation,
                                isPurplishMode: widget.isPurplishMode,
                                isDarkMode: widget.isDarkMode,
                                hasCustomColors: widget.hasCustomColors,
                                colors: widget.colors.length == 3
                                    ? widget.colors
                                    : defaultColors),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

//
// **************************************buildButtomBox**********************************
//
Widget buildButtomBox(Animation _animation,
    {required double width,
    required double height,
    required bool isDarkMode,
    required bool isRectBox,
    required bool isPurplishMode,
    required AlignmentGeometry beginAlign,
    required AlignmentGeometry endAlign,
    required bool hasCustomColors,
    required List<Color> colors,
    bool isVideoShimmer = false}) {
  return Container(
    margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
    height: isVideoShimmer ? width * 0.4 : width * 0.4,
    width: isVideoShimmer ? width : width,
    decoration: customBoxDecoration(
        animation: _animation,
        isDarkMode: isDarkMode,
        isPurplishMode: isPurplishMode,
        isRectBox: isRectBox,
        beginAlign: beginAlign,
        endAlign: endAlign,
        hasCustomColors: hasCustomColors,
        colors: colors.length == 3 ? colors : defaultColors),
  );
}
//

// **************************************CustomBoxDecoration****************************
// [animation]
// [isRectBox]
// [isDarkMode]
// [beginAlign]
// [endAlign]
//
Decoration customBoxDecoration({
  required Animation animation,
  bool isRectBox = false,
  bool isDarkMode = false,
  bool isPurplishMode = false,
  bool hasCustomColors = false,
  List<Color> colors = defaultColors,
  AlignmentGeometry beginAlign = Alignment.topLeft,
  AlignmentGeometry endAlign = Alignment.bottomRight,
}) {
  return BoxDecoration(
      shape: isRectBox ? BoxShape.rectangle : BoxShape.circle,
      gradient: LinearGradient(
          begin: beginAlign,
          end: endAlign,
          colors: hasCustomColors
              ? colors.map((color) {
                  return color;
                }).toList()
              : [
                  isPurplishMode
                      ? Color(0xFF8D71A9)
                      : isDarkMode
                          ? Color(0xFF1D1D1D)
                          : Color.fromRGBO(0, 0, 0, 0.1),
                  isPurplishMode
                      ? Color(0xFF36265A)
                      : isDarkMode
                          ? Color(0XFF3C4042)
                          : Color(0x44CCCCCC),
                  isPurplishMode
                      ? Color(0xFF8D71A9)
                      : isDarkMode
                          ? Color(0xFF1D1D1D)
                          : Color.fromRGBO(0, 0, 0, 0.1),
                ],
          stops: [animation.value - 2, animation.value, animation.value + 1]));
}

// **************************************CustomBoxDecoration****************************
// [animation]
// [isDarkMode]
// [beginAlign]
// [endAlign]
//
Decoration radiusBoxDecoration(
    {required Animation animation,
    bool isDarkMode = false,
    bool isPurplishMode = false,
    bool hasCustomColors = false,
    AlignmentGeometry beginAlign = Alignment.topLeft,
    AlignmentGeometry endAlign = Alignment.bottomRight,
    List<Color> colors = defaultColors,
    double radius = 10.0}) {
  return BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      shape: BoxShape.rectangle,
      gradient: LinearGradient(
          begin: beginAlign,
          end: endAlign,
          colors: hasCustomColors
              ? colors.map((color) {
                  return color;
                }).toList()
              : [
                  isPurplishMode
                      ? Color(0xFF8D71A9)
                      : isDarkMode
                          ? Color(0xFF1D1D1D)
                          : Color.fromRGBO(0, 0, 0, 0.1),
                  isPurplishMode
                      ? Color(0xFF36265A)
                      : isDarkMode
                          ? Color(0XFF3C4042)
                          : Color(0x44CCCCCC),
                  isPurplishMode
                      ? Color(0xFF8D71A9)
                      : isDarkMode
                          ? Color(0xFF1D1D1D)
                          : Color.fromRGBO(0, 0, 0, 0.1),
                ],
          stops: [animation.value - 2, animation.value, animation.value + 1]));
}
//
// **************************************CustomBoxDecoration****************************
//
//