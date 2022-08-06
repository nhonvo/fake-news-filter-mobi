import 'package:fake_news/core/models/api/base_response_api_model.dart';
import 'package:fake_news/models/language_model.dart';
import 'dio_api.dart';

abstract class LanguageApi {
  Future<BaseResponse<List<LanguageModel>>> getLanguages();
}

class LanguageApiImpl implements LanguageApi {
  DioApi dioApi;
  LanguageApiImpl({required this.dioApi});

  @override
  Future<BaseResponse<List<LanguageModel>>> getLanguages() async {
    return await dioApi.doGet<List<LanguageModel>>(
      "/api/Language/List",
      parseJson: (json) =>
          List<LanguageModel>.from(json.map((x) => LanguageModel.fromJson(x))),
    );
  }
}
