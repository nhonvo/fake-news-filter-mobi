import 'package:fake_news/resources/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'avatar.dart';

class CardCommunity extends StatefulWidget {
  final String? avatar;
  final String crowdId, times, title, content, nameCrowd;
  final double? width, height;
  final int numberCrowd;

  final VoidCallback onpress;

  const CardCommunity(
      {Key? key,
      this.avatar,
      required this.crowdId,
      required this.times,
      required this.title,
      required this.content,
      required this.nameCrowd,
      required this.numberCrowd,
      this.width = 230,
      this.height = 150,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatarCustom(
                        url:
                            'https://scontent.fdad3-4.fna.fbcdn.net/v/t1.6435-9/103099051_1406544689546058_2645542971869687953_n.jpg?_nc_cat=104&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=P-9rMj4otgkAX8r_sC0&_nc_ht=scontent.fdad3-4.fna&oh=00_AT-a-2j3l6iVNg44Xg9TSjNk3zOKUcGHKw-73ZsxrsqGPw&oe=61E379FF',
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
                              Text(widget.numberCrowd.toString(),
                                  style: StylesText.content10BoldBlack)
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
