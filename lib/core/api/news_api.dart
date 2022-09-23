import 'package:fake_news/core/models/api/base_response_api_model.dart';
import 'package:fake_news/models/news/news_model.dart';

import 'dio_api.dart';

abstract class NewsApi {
  Future<BaseResponse<List<NewsModel>>> getNews(String? filter, String? languageId, int pageIndex, int pageSize);
  Future<BaseResponse<List<NewsModel>>> getNewsPaging(String? languageId, int pageIndex, int pageSize);
  Future<BaseResponse<List<NewsModel>>> getNewsByTopicId(int? topicId, int pageIndex, int pageSize);
  Future<BaseResponse<List<NewsModel>>> getNewsByFollowedTopic(String userId, int pageIndex, int pageSize);
  Future<BaseResponse<dynamic>> getViewCount(int newsId);
}

class NewsApiIpml implements NewsApi {
  DioApi dioApi;
  NewsApiIpml({required this.dioApi});

  Future<BaseResponse<List<NewsModel>>> getNews(String? filter, String? languageId, int pageIndex, int pageSize) async {
    return await dioApi.doGet<List<NewsModel>>(
      "/api/News?keyword=$filter&languageId=$languageId&PageIndex=$pageIndex&PageSize=$pageSize",
      parseJson: (json) =>
          json["items"] == null ? [] : List<NewsModel>.from(json["items"].map((x) => NewsModel.fromJson(x))),
    );
  }

  Future<BaseResponse<List<NewsModel>>> getNewsPaging(String? languageId, int pageIndex, int pageSize) async {
    return await dioApi.doGet<List<NewsModel>>(
      "/api/News/Paging?languageId=$languageId&PageIndex=$pageIndex&PageSize=$pageSize",
      parseJson: (json) =>
          json["items"] == null ? [] : List<NewsModel>.from(json["items"].map((x) => NewsModel.fromJson(x))),
    );
  }

  Future<BaseResponse<List<NewsModel>>> getNewsByTopicId(int? topicId, int pageIndex, int pageSize) async {
    return await dioApi.doGet<List<NewsModel>>(
      "/api/News/Topic?TopicId=$topicId&PageIndex=$pageIndex&PageSize=$pageSize",
      parseJson: (json) =>
          json["items"] == null ? [] : List<NewsModel>.from(json["items"].map((x) => NewsModel.fromJson(x))),
    );
  }

  Future<BaseResponse<List<NewsModel>>> getNewsByFollowedTopic(String userId, int pageIndex, int pageSize) async {
    return await dioApi.doGet<List<NewsModel>>(
      "/api/News/FollowedTopic?userId=$userId&PageIndex=$pageIndex&PageSize=$pageSize",
      parseJson: (json) =>
          json["items"] == null ? [] : List<NewsModel>.from(json["items"].map((x) => NewsModel.fromJson(x))),
    );
  }

  @override
  Future<BaseResponse<dynamic>> getViewCount(int newsId) async {
    return await dioApi.doGet("/api/News/Views/$newsId");
  }
}
