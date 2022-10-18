import 'dart:convert';

import 'package:fake_news/core/models/api/base_response_api_model.dart';
import 'package:fake_news/models/comment/comment_model.dart';

import 'dio_api.dart';

abstract class CommentApi {
  Future<BaseResponse<List<CommentModel>>> getCommentsInNews(String newsId);
  Future<BaseResponse<CommentModel>> addComment(String userId, String newsId, String content, String? parentId);
}

class CommentApiImpl implements CommentApi {
  DioApi dioApi;
  CommentApiImpl({required this.dioApi});

  @override
  Future<BaseResponse<List<CommentModel>>> getCommentsInNews(String newsId) async {
    return await dioApi.doGet<List<CommentModel>>(
      "/api/Comment/News/$newsId",
      parseJson: (json) => List<CommentModel>.from(json.map((x) => CommentModel.fromJson(x))),
    );
  }

  @override
  Future<BaseResponse<CommentModel>> addComment(String userId, String newsId, String content, String? parentId) async {
    return await dioApi.doPost<CommentModel>(
      "/api/Comment",
      {
        "UserId": userId,
        "NewsId": newsId,
        "Content": content,
        "ParentId": parentId,
      },
      parseJson: ((json) => CommentModel.fromJson(json)),
    );
  }
}
