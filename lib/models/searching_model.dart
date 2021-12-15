import 'package:fake_news/models/news/news_model.dart';
import 'package:fake_news/models/topics/topic_model.dart';

class SearchingModel {
  int? countTopic;
  List<TopicModel?>? topicNews;
  int? countNews;
  List<NewsModel?>? news;

  SearchingModel({
    this.countTopic,
    this.topicNews,
    this.countNews,
    this.news,
  });
  SearchingModel.fromJson(Map<String, dynamic> json) {
    countTopic = json['countTopic']?.toInt();
    if (json['topicNews'] != null) {
      final v = json['topicNews'];
      final arr0 = <TopicModel>[];
      v.forEach((v) {
        arr0.add(TopicModel.fromJson(v));
      });
      topicNews = arr0;
    }
    countNews = json['countNews']?.toInt();
    if (json['news'] != null) {
      final v = json['news'];
      final arr0 = <NewsModel>[];
      v.forEach((v) {
        arr0.add(NewsModel.fromJson(v));
      });
      news = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['countTopic'] = countTopic;
    if (topicNews != null) {
      final v = topicNews;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['topicNews'] = arr0;
    }
    data['countNews'] = countNews;
    if (news != null) {
      final v = news;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['news'] = arr0;
    }
    return data;
  }
}
