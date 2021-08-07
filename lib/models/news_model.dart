import 'package:fake_news/models/story_model.dart';

/// Example Data Model
class NewsModel {
  final String name;
  final String imageUrl;
  final List<StoryModel> stories; 

  const NewsModel({required this.name, required this.imageUrl,required this.stories, });
}
