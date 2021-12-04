import 'package:fake_news/core/models/api/base_response_api_model.dart';

import 'dio_api.dart';

abstract class FollowingApi {
  Future<BaseResponse<List<int>>> getFollowedTopic(String userId);
  Future<BaseResponse<bool>> createFollow(List<int> topicIdList, String userId);
}

class FollowingApiImpl implements FollowingApi {
  DioApi dioApi;
  FollowingApiImpl({required this.dioApi});

  @override
  Future<BaseResponse<List<int>>> getFollowedTopic(String userId) async {
    return await dioApi.doGet<List<int>>(
      "/api/Follow/$userId",
      parseJson: (json) => List<int>.from(json),
    );
  }

  @override
  Future<BaseResponse<bool>> createFollow(List<int> topicIdList, String userId) async {
    return await dioApi.doPost<bool>(
      "/api/Follow",
      {'TopicId': topicIdList, 'UserId': userId},
    );
  }
}
