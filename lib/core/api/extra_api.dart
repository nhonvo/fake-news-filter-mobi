import 'package:fake_news/core/models/api/base_response_api_model.dart';
import 'package:fake_news/models/searching_model.dart';
import 'dio_api.dart';

abstract class ExtraApi {
  Future<BaseResponse<SearchingModel>> search(String keyword, String languageId);
}

class ExtraApiImpl implements ExtraApi {
  DioApi dioApi;
  ExtraApiImpl({required this.dioApi});

  @override
  Future<BaseResponse<SearchingModel>> search(String keyword, String languageId) async {
    return await dioApi.doGet<SearchingModel>(
      "/api/ExtraFeatures/Search?keyword=$keyword&languageId=$languageId",
      parseJson: (json) => SearchingModel.fromJson(json),
    );
  }
}
