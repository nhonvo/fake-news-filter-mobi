import 'dart:math';

import 'package:flutter/material.dart';

import '../utils/image.dart';

class NumberProgress extends StatelessWidget {
  final double height;

  final double value;

  final Color? backgroundColor;

  final Color valueColor;

  final Color textColor;

  final double textSize;

  final AlignmentGeometry textAlignment;

  final EdgeInsetsGeometry padding;

  NumberProgress(
      {Key? key,
      this.height = 10.0,
      this.value = 0.0,
      this.backgroundColor,
      this.valueColor = Colors.blue,
      this.textColor = Colors.white,
      this.textSize = 8.0,
      this.padding = EdgeInsets.zero,
      this.textAlignment = Alignment.center})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: padding,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            SizedBox(
              height: height,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(height)),
                child: LinearProgressIndicator(
                  value: value,
                  backgroundColor: backgroundColor,
                  valueColor: AlwaysStoppedAnimation<Color>(valueColor),
                ),
              ),
            ),
            Container(
              height: height,
              alignment: textAlignment,
              child: Text(
                value >= 1 ? '100%' : '${(value * 100).toInt()}%',
                style: TextStyle(
                  color: textColor,
                  fontSize: textSize,
                ),
              ),
            ),
          ],
        ));
  }
}

class UpdateDialog {
  bool _isShowing = false;
  late BuildContext _context;
  late UpdateWidget _widget;

  UpdateDialog(BuildContext context,
      {double width = 0.0,
      required String title,
      required String updateContent,
      required VoidCallback onUpdate,
      double titleTextSize = 16.0,
      double contentTextSize = 14.0,
      double buttonTextSize = 14.0,
      double progress = -1.0,
      Color progressBackgroundColor = const Color(0xFFFFCDD2),
      Image? topImage,
      double extraHeight = 5.0,
      double radius = 4.0,
      Color themeColor = Colors.red,
      bool enableIgnore = false,
      VoidCallback? onIgnore,
      bool isForce = false,
      String? updateButtonText,
      String? ignoreButtonText,
      VoidCallback? onClose}) {
    _context = context;
    _widget = UpdateWidget(
        width: width,
        title: title,
        updateContent: updateContent,
        onUpdate: onUpdate,
        titleTextSize: titleTextSize,
        contentTextSize: contentTextSize,
        buttonTextSize: buttonTextSize,
        progress: progress,
        topImage: topImage,
        extraHeight: extraHeight,
        radius: radius,
        themeColor: themeColor,
        progressBackgroundColor: progressBackgroundColor,
        enableIgnore: enableIgnore,
        onIgnore: onIgnore,
        isForce: isForce,
        updateButtonText: updateButtonText ?? 'Cập nhật',
        ignoreButtonText: ignoreButtonText ?? 'Bỏ qua',
        onClose: onClose ?? () => dismiss());
  }

  Future<bool> show() {
    try {
      if (isShowing()) {
        return Future<bool>.value(false);
      }
      showDialog<bool>(
          context: _context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return WillPopScope(
                onWillPop: () => Future<bool>.value(false), child: _widget);
          });
      _isShowing = true;
      return Future<bool>.value(true);
    } catch (err) {
      _isShowing = false;
      return Future<bool>.value(false);
    }
  }

  Future<bool> dismiss() {
    try {
      if (_isShowing) {
        _isShowing = false;
        Navigator.pop(_context);
        return Future<bool>.value(true);
      } else {
        return Future<bool>.value(false);
      }
    } catch (err) {
      return Future<bool>.value(false);
    }
  }

  bool isShowing() {
    return _isShowing;
  }

  void update(double progress) {
    if (isShowing()) {
      _widget.update(progress);
    }
  }

  static UpdateDialog showUpdate(BuildContext context,
      {double width = 0.0,
      required String title,
      required String updateContent,
      required VoidCallback onUpdate,
      double titleTextSize = 16.0,
      double contentTextSize = 14.0,
      double buttonTextSize = 14.0,
      double progress = -1.0,
      Color progressBackgroundColor = const Color(0xFFFFCDD2),
      Image? topImage,
      double extraHeight = 5.0,
      double radius = 4.0,
      Color themeColor = Colors.red,
      bool enableIgnore = false,
      VoidCallback? onIgnore,
      String? updateButtonText,
      String? ignoreButtonText,
      bool isForce = false}) {
    final UpdateDialog dialog = UpdateDialog(context,
        width: width,
        title: title,
        updateContent: updateContent,
        onUpdate: onUpdate,
        titleTextSize: titleTextSize,
        contentTextSize: contentTextSize,
        buttonTextSize: buttonTextSize,
        progress: progress,
        topImage: topImage,
        extraHeight: extraHeight,
        radius: radius,
        themeColor: themeColor,
        progressBackgroundColor: progressBackgroundColor,
        enableIgnore: enableIgnore,
        isForce: isForce,
        updateButtonText: updateButtonText,
        ignoreButtonText: ignoreButtonText,
        onIgnore: onIgnore);
    dialog.show();
    return dialog;
  }
}

// ignore: must_be_immutable
class UpdateWidget extends StatefulWidget {
  final double width;

  final String title;

  final String updateContent;

  final double titleTextSize;

  final double contentTextSize;

  final double buttonTextSize;

  final Widget? topImage;

  final double extraHeight;

  final double radius;

  final Color themeColor;

  /// Hàm khi ấn nút cập nhật
  final VoidCallback onUpdate;

  /// Cho phép bỏ qua
  final bool enableIgnore;

  /// Hàm khi bỏ qua
  final VoidCallback? onIgnore;

  double progress;

  final Color progressBackgroundColor;

  /// Hàm khi đóng
  final VoidCallback? onClose;

  ///Bắt buộc cập nhật
  final bool isForce;

  ///Nút cập nhật
  final String updateButtonText;

  ///Nút bỏ qua
  final String ignoreButtonText;

  UpdateWidget(
      {Key? key,
      this.width = 0.0,
      required this.title,
      required this.updateContent,
      required this.onUpdate,
      this.titleTextSize = 16.0,
      this.contentTextSize = 14.0,
      this.buttonTextSize = 14.0,
      this.progress = -1.0,
      this.progressBackgroundColor = const Color(0xFFFFCDD2),
      this.topImage,
      this.extraHeight = 5.0,
      this.radius = 4.0,
      this.themeColor = Colors.red,
      this.enableIgnore = false,
      this.onIgnore,
      this.isForce = false,
      this.updateButtonText = 'Cập nhật',
      this.ignoreButtonText = 'Bỏ qua',
      this.onClose})
      : super(key: key);

  final _UpdateWidgetState _state = _UpdateWidgetState();

  void update(double progress) {
    _state.update(progress);
  }

  @override
  _UpdateWidgetState createState() => _state;
}

class _UpdateWidgetState extends State<UpdateWidget> {
  void update(double progress) {
    if (!mounted) {
      return;
    }
    setState(() {
      widget.progress = progress;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double dialogWidth =
        widget.width <= 0 ? getFitWidth(context) * 0.618 : widget.width;
    return Material(
        type: MaterialType.transparency,
        child: Container(
          child: SizedBox(
            width: dialogWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: dialogWidth,
                  child: widget.topImage ??
                      Image.asset(Images.update_bg_app_top, fit: BoxFit.fill),
                ),
                Container(
                  width: dialogWidth,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 8, bottom: 8),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(widget.radius),
                          bottomRight: Radius.circular(widget.radius)),
                    ),
                  ),
                  child: SingleChildScrollView(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: widget.extraHeight),
                        child: Text(widget.title,
                            style: TextStyle(
                                fontSize: widget.titleTextSize,
                                color: Colors.black)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(widget.updateContent,
                            style: TextStyle(
                                fontSize: widget.contentTextSize,
                                color: const Color(0xFF666666))),
                      ),
                      if (widget.progress < 0)
                        Column(children: <Widget>[
                          FractionallySizedBox(
                            widthFactor: 1,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                textStyle: MaterialStateProperty.all(
                                    TextStyle(fontSize: widget.buttonTextSize)),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5))),
                                elevation: MaterialStateProperty.all(0),
                                backgroundColor: MaterialStateProperty.all(
                                    widget.themeColor),
                              ),
                              child: Text(widget.updateButtonText),
                              onPressed: widget.onUpdate,
                            ),
                          ),
                          if (widget.enableIgnore && widget.onIgnore != null)
                            FractionallySizedBox(
                                widthFactor: 1,
                                child: TextButton(
                                  style: ButtonStyle(
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    textStyle: MaterialStateProperty.all(
                                        TextStyle(
                                            fontSize: widget.buttonTextSize)),
                                    foregroundColor: MaterialStateProperty.all(
                                        const Color(0xFF666666)),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5))),
                                  ),
                                  child: Text(widget.ignoreButtonText),
                                  onPressed: widget.onIgnore,
                                ))
                          else
                            const SizedBox()
                        ])
                      else
                        NumberProgress(
                            value: widget.progress,
                            backgroundColor: widget.progressBackgroundColor,
                            valueColor: widget.themeColor,
                            padding: const EdgeInsets.symmetric(vertical: 10))
                    ],
                  )),
                ),
                if (!widget.isForce)
                  Column(children: <Widget>[
                    const SizedBox(
                        width: 1.5,
                        height: 50,
                        child: DecoratedBox(
                            decoration: BoxDecoration(color: Colors.white))),
                    IconButton(
                      iconSize: 30,
                      constraints:
                          const BoxConstraints(maxHeight: 30, maxWidth: 30),
                      padding: EdgeInsets.zero,
                      icon: Image.asset(Images.update_ic_close),
                      onPressed: widget.onClose,
                    )
                  ])
                else
                  const SizedBox()
              ],
            ),
          ),
        ));
  }

  double getFitWidth(BuildContext context) {
    return min(getScreenHeight(context), getScreenWidth(context));
  }

  double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}
