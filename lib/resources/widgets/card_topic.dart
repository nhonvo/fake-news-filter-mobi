import 'package:fake_news/resources/utils/image.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/resources/widgets/tag.dart';
import 'package:flutter/material.dart';

class CardTopic extends StatefulWidget {
  const CardTopic({Key? key}) : super(key: key);

  @override
  _CardTopicState createState() => _CardTopicState();
}

class _CardTopicState extends State<CardTopic> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
              width: 250,
              height: 210,
              decoration: BoxDecoration(
                  color: MyColors.card1,
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              child: Column(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0)),
                      child: Image.asset(Images.covid)),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TagTopic(
                            tagName: '#covid19',
                            buttonColor: MyColors.red.withOpacity(0.1),
                          ),
                          Text(
                            'Outbreak of respiratory virus that has killed over 1 milion and infected 100 virus',
                            style: StylesText.content12MediumWhite,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.menu,
                                    color: Colors.white,
                                  ),
                                  Text('3,4k',
                                      style: StylesText.content12MediumWhite)
                                ],
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.sync_rounded,
                                    color: Colors.white,
                                  ),
                                  Text('9 hrs',
                                      style: StylesText.content12MediumWhite)
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )),
          Positioned(
            top: -10,
            left: -10,
            child: Container(
              width: 80,
              height: 25,
              decoration: BoxDecoration(
                  color: MyColors.orange,
                  borderRadius: BorderRadius.all(Radius.circular(13.0))),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.star_rounded,
                    color: Colors.white,
                  ),
                  Text('featured', style: StylesText.content12BoldWhite)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
