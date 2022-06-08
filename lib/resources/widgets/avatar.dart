import 'package:cached_network_image/cached_network_image.dart';
import 'package:fake_news/resources/utils/image.dart';
import 'package:flutter/material.dart';

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
    return SizedBox(
      height: radius * 2,
      width: radius * 2,
      child: url == null
          ? Image.asset(
              Images.avatar,
              fit: BoxFit.fill,
            )
          : CachedNetworkImage(
              imageUrl: url!,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
                child: stackWidget,
              ),
              errorWidget: (context, url, error) => Image.asset(
                Images.avatar,
                fit: BoxFit.fill,
              ),
            ),
    );
  }
}
