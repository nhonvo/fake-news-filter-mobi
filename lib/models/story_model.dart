import 'package:fake_news/models/news_model.dart';

enum MediaType {
  image,
  video,
}

class StoryModel {
  final String url;
  final MediaType media;
  final Duration duration;

  StoryModel(
      {required this.media,
      required this.duration,
      required this.url});
}
