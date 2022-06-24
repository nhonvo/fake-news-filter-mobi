import 'package:dio/dio.dart';
import 'package:fake_news/core/models/api/base_response_api_model.dart';
import 'package:fake_news/models/news_comnunity_model.dart';

import 'dio_api.dart';

abstract class NewsCommunityApi {
  Future<BaseResponse<List<NewsCommunityModel>>> getNewsCommunity(String? languageId);
  Future<BaseResponse<NewsCommunityModel>> createNewsCommunity(
      String title, String content, String? languageId, String userId, List<int> imageBytes, String filename);
  // Future<BaseResponse<List<NewsModel>>> getNewsByTopicId(int? topicId);
  // Future<BaseResponse<List<NewsModel>>> getNewsByFollowedTopic(String userId);
}

class NewsCommunityApiImpl implements NewsCommunityApi {
  DioApi dioApi;
  NewsCommunityApiImpl({required this.dioApi});

  Future<BaseResponse<List<NewsCommunityModel>>> getNewsCommunity(String? languageId) async {
    return await dioApi.doGet<List<NewsCommunityModel>>(
      "/api/NewsCommunity?languageId=$languageId",
      parseJson: (json) => List<NewsCommunityModel>.from(json.map((x) => NewsCommunityModel.fromJson(x))),
    );
  }

  Future<BaseResponse<NewsCommunityModel>> createNewsCommunity(
      String title, String content, String? languageId, String userId, List<int> imageBytes, String filename) async {
    var formData = FormData.fromMap({
      'title': title,
      'content': content,
      'languageId': languageId,
      'userId': userId,
      // 'thumbNews':
      'thumbNews': await MultipartFile.fromBytes(imageBytes, filename: filename)
    });
    return await dioApi.doPost<NewsCommunityModel>("/api/NewsCommunity", formData);
  }

  // Future<BaseResponse<List<NewsModel>>> getNewsByTopicId(int? topicId) async {
  //   return await dioApi.doGet<List<NewsModel>>(
  //     "/api/News/Topic?TopicId=$topicId",
  //     parseJson: (json) => List<NewsModel>.from(json.map((x) => NewsModel.fromJson(x))),
  //   );
  // }

  // Future<BaseResponse<List<NewsModel>>> getNewsByFollowedTopic(String userId) async {
  //   return await dioApi.doGet<List<NewsModel>>(
  //     "/api/News/FollowedTopic?userId=$userId",
  //     parseJson: (json) => List<NewsModel>.from(json.map((x) => NewsModel.fromJson(x))),
  //   );
  // }
}
