// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fake_news/models/news1_model.dart';
import 'package:fake_news/views/story/story_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget storyButton(NewsModel1 news, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () {
            Get.to(() => StoryScreen(news: news));
          },
          child: Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50), border: Border.all(color: Colors.red, width: 2.0)),
            child: Padding(
                padding: EdgeInsets.all(3.0),
                child: CachedNetworkImage(
                  imageUrl: news.imageUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )),
          ),
        ),
      ],
    ),
  );
}
