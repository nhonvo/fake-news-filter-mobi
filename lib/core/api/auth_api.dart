import 'package:fake_news/core/models/api/base_response_api_model.dart';
import 'package:fake_news/models/users/login_model.dart';
import 'package:fake_news/models/users/user_model.dart';

import 'dio_api.dart';

abstract class AuthApi {
  Future<BaseResponse<LoginModel>> login(String email, String password);
  Future<BaseResponse<UserModel>> register(UserModel model);
  Future<BaseResponse<String>> requestResetPassword(String email);
  Future<BaseResponse<String>> resetPassword(String code, String newPass, String cfNewPass);
  Future<BaseResponse<UserModel>> changePassword(String currentPass, String newPass, String confirmPass);
  Future<BaseResponse<String>> logout();
  Future<BaseResponse<UserModel>> changeProfile(UserModel model);
}

class AuthApiIpml implements AuthApi {
  DioApi dioApi;
  AuthApiIpml({required this.dioApi});

  Future<BaseResponse<LoginModel>> login(String username, String password) async {
    return await dioApi.doPost<LoginModel>(
      "/api/Users/Authenticate",
      {'username': username, 'password': password},
      parseJson: (json) => LoginModel.fromJson(json),
    );
  }

  @override
  Future<BaseResponse<UserModel>> register(UserModel model) async {
    return await dioApi.doPost("/partner/signUp", model.toJson(), parseJson: (json) => UserModel.fromJson(json));
  }

  @override
  Future<BaseResponse<String>> requestResetPassword(String email) async {
    return await dioApi.doPost(
      "/partner/requestResetPassword",
      {'email': email},
      parseJson: (json) => json,
    );
  }

  @override
  Future<BaseResponse<UserModel>> changePassword(String currentPass, String newPass, String confirmPass) async {
    return await dioApi.doPut(
      "/partner/changePassword",
      {"currentPassword": currentPass, "newPassword": newPass, "confirmNewPassword": confirmPass},
      parseJson: (json) => UserModel.fromJson(json),
    );
  }

  @override
  Future<BaseResponse<String>> logout() async {
    return await dioApi.doPut(
      "/auth/logout",
      {},
      parseJson: (json) => json,
    );
  }

  @override
  Future<BaseResponse<UserModel>> changeProfile(UserModel model) {
    throw UnimplementedError();
  }

  @override
  Future<BaseResponse<String>> resetPassword(String code, String newPass, String cfNewPass) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }
}
