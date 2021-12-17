import 'package:fake_news/core/models/api/base_response_api_model.dart';
import 'package:fake_news/models/news/news_model.dart';

import 'dio_api.dart';

abstract class NewsApi {
  Future<BaseResponse<List<NewsModel>>> getNews(String? filter, String? languageId);
  Future<BaseResponse<List<NewsModel>>> getNewsByTopicId(int? topicId);
  Future<BaseResponse<List<NewsModel>>> getNewsByFollowedTopic(String userId);
}

class NewsApiIpml implements NewsApi {
  DioApi dioApi;
  NewsApiIpml({required this.dioApi});

  Future<BaseResponse<List<NewsModel>>> getNews(String? filter, String? languageId) async {
    return await dioApi.doGet<List<NewsModel>>(
      "/api/News?filter=$filter&languageId=$languageId",
      parseJson: (json) => List<NewsModel>.from(json.map((x) => NewsModel.fromJson(x))),
    );
  }

  Future<BaseResponse<List<NewsModel>>> getNewsByTopicId(int? topicId) async {
    return await dioApi.doGet<List<NewsModel>>(
      "/api/News/Topic?TopicId=$topicId",
      parseJson: (json) => List<NewsModel>.from(json.map((x) => NewsModel.fromJson(x))),
    );
  }

  Future<BaseResponse<List<NewsModel>>> getNewsByFollowedTopic(String userId) async {
    return await dioApi.doGet<List<NewsModel>>(
      "/api/News/FollowedTopic?userId=$userId",
      parseJson: (json) => List<NewsModel>.from(json.map((x) => NewsModel.fromJson(x))),
    );
  }
}
