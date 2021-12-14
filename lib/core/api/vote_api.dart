import 'package:fake_news/core/models/api/base_response_api_model.dart';
import 'dio_api.dart';

abstract class VoteApi {
  Future<BaseResponse<bool>> createVote(String newsId, String userId, bool isReal);
}

class VoteApiImpl implements VoteApi {
  DioApi dioApi;
  VoteApiImpl({required this.dioApi});

  @override
  Future<BaseResponse<bool>> createVote(String userId, String newsId, bool isReal) async {
    return await dioApi.doPost<bool>(
      "/api/Vote",
      {'UserId': userId, 'NewsId': newsId, 'isReal': isReal},
    );
  }
}
