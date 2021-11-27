import 'package:fake_news/core/models/api/base_response_api_model.dart';
import 'package:fake_news/models/topics/topic_model.dart';

import 'dio_api.dart';

abstract class TopicApi {
  Future<BaseResponse<List<TopicModel>>> getTopic(String? languageId);
}

class TopicApiIpml implements TopicApi {
  DioApi dioApi;
  TopicApiIpml({required this.dioApi});

  Future<BaseResponse<List<TopicModel>>> getTopic(String? languageId) async {
    return await dioApi.doGet<List<TopicModel>>(
      //FIXME: change to real url
      "/api/Topic/List?languageId=${languageId}",
      parseJson: (json) => List<TopicModel>.from(json.map((x) => TopicModel.fromJson(x))),
    );
  }
}
