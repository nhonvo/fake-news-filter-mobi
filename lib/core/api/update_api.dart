import 'package:fake_news/core/models/api/base_response_api_model.dart';
import 'package:fake_news/models/update_model.dart';
import 'dio_api.dart';

abstract class UpdateApi {
  Future<BaseResponse<VersionModel>> checkUpdate(
      String currentVersion, String platform);
}

class UpdateApiImpl implements UpdateApi {
  DioApi dioApi;
  UpdateApiImpl({required this.dioApi});

  @override
  Future<BaseResponse<VersionModel>> checkUpdate(
      String currentVersion, String platform) async {
    return await dioApi.doGet<VersionModel>(
      "/api/Version/CheckLastest?version_current=$currentVersion&platform=$platform",
      parseJson: (json) => VersionModel.fromJson(json),
    );
  }
}
