import 'package:fake_news/models/news_model.dart';
import 'package:fake_news/models/story_model.dart';

final List<NewsModel> news = [
  NewsModel(
      name: 'CNN',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/6/66/CNN_International_logo.svg/1200px-CNN_International_logo.svg.png',
      stories: stories),
  NewsModel(
      name: 'New York Times',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/4/40/New_York_Times_logo_variation.jpg',
      stories: stories),
  NewsModel(
      name: 'BBC News',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/en/thumb/f/ff/BBC_News.svg/1200px-BBC_News.svg.png',
      stories: stories),
  NewsModel(
      name: 'abc News',
      imageUrl:
          'https://s.abcnews.com/assets/beta/assets/abcn_images/abcnews_pearl_stacked.png',
      stories: stories),
  NewsModel(
      name: 'Fox News',
      imageUrl:
          'https://www.bark.us/blog/wp-content/uploads/2019/04/Fox-news-logo.png',
      stories: stories),
];

final List<StoryModel> stories = [
  StoryModel(
    url:
        'https://static01.nyt.com/images/2021/08/09/multimedia/09virus-briefing-military-01/09virus-briefing-military-01-superJumbo-v2.jpg?quality=90&auto=webp',
    media: MediaType.image,
    duration: const Duration(seconds: 10),
  ),
  StoryModel(
    url:
        'https://link.theplatform.com/s/rksNhC/SWLJ1OlJC6cG?mbr=true&format=redirect&manifest=m3u&format=redirect&Tracking=true&Embedded=true&formats=MPEG4',
    media: MediaType.video,
    duration: const Duration(seconds: 10),
  ),
  StoryModel(
    url:
        'https://link.theplatform.com/s/rksNhC/TBkhZbtGojSD?mbr=true&format=redirect&manifest=m3u&format=redirect&Tracking=true&Embedded=true&formats=MPEG4',
    media: MediaType.video,
    duration: const Duration(seconds: 10),
  )
];
