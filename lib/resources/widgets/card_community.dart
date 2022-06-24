import 'package:cached_network_image/cached_network_image.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:flutter/material.dart';

import 'avatar.dart';

class CardCommunity extends StatefulWidget {
  final String? avatar, thumbNews;
  final String crowdId, times, title, content, nameCrowd;
  final double? width, height;
  final int numberCrowd;

  final VoidCallback onpress;

  const CardCommunity(
      {Key? key,
      this.avatar,
      this.thumbNews,
      required this.crowdId,
      required this.times,
      required this.title,
      required this.content,
      required this.nameCrowd,
      required this.numberCrowd,
      this.width = 230,
      this.height = 200,
      required this.onpress})
      : super(key: key);

  @override
  _CardCommunityState createState() => _CardCommunityState();
}

class _CardCommunityState extends State<CardCommunity> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onpress,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300,
            style: BorderStyle.solid,
            width: 1.0,
          ),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(10),
        width: widget.width,
        height: widget.height,
        child: Column(
          children: [
            Text(
              widget.title,
              style: StylesText.content14BoldBlack,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            Expanded(
              flex: 2,
              child: Card(
                child: Image.network(
                  widget.thumbNews!,
                  fit: BoxFit.fill,
                  errorBuilder: (context, url, error) {
                    return Icon(Icons.error);
                  },
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatarCustom(
                        url: widget.avatar,
                        radius: 17,
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Được đóng góp bởi:",
                            style: StylesText.content10MediumBlack,
                          ),
                          Text(
                            widget.nameCrowd,
                            style: StylesText.content12BoldBlack,
                          ),
                          Row(
                            children: [
                              Text(
                                "Số tin đã đóng góp:",
                                style: StylesText.content10MediumBlack,
                              ),
                              Text(widget.numberCrowd.toString(), style: StylesText.content10BoldBlack)
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: 20,
                        color: MyColors.greyDark,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.times,
                        style: StylesText.content12BoldGrey,
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
