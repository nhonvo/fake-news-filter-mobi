import 'package:fake_news/models/story_model.dart';

/// Example Data Model
class NewsModel1 {
  final String name;
  final String imageUrl;
  final List<StoryModel> stories;

  const NewsModel1({
    required this.name,
    required this.imageUrl,
    required this.stories,
  });
}
