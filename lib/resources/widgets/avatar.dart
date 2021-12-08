import 'package:cached_network_image/cached_network_image.dart';
import 'package:fake_news/resources/utils/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CircleAvatarCustom extends StatelessWidget {
  final String? url;
  final double radius;
  final Widget? stackWidget;
  final Color borderColor;
  final Color? backgroundColor;
  const CircleAvatarCustom(
      {Key? key,
      this.url,
      required this.radius,
      this.stackWidget,
      this.backgroundColor,
      this.borderColor = Colors.blue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      child: Stack(
        children: <Widget>[
          Container(
              width: radius * 2,
              height: radius * 2,
              decoration: (url != "" || url != null)
                  ? BoxDecoration(
                      shape: BoxShape.circle,
                      color: backgroundColor ?? Colors.blue[400],
                      image: DecorationImage(
                        fit: BoxFit.scaleDown,
                        image: ExactAssetImage(
                          Images.avatar,
                        ),
                      ),
                    )
                  : BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(url!),
                      ),
                    )),
          Align(
            alignment: Alignment.bottomRight,
            child: stackWidget,
          )
        ],
      ),
    );
  }
}
