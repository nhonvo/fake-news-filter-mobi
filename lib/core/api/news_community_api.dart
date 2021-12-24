import 'package:fake_news/core/models/api/base_response_api_model.dart';
import 'package:fake_news/models/news_comnunity_model.dart';

import 'dio_api.dart';

abstract class NewsCommunityApi {
  Future<BaseResponse<List<NewsCommunityModel>>> getNewsCommunity(String? languageId);
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