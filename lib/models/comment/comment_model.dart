/*
{
            "commentId": 2,
            "parentId": 0,
            "content": "Tin tuc gi ki qua a",
            "newsId": 7245,
            "userId": "69db714f-9576-45ba-b5b7-f00649be03de",
            "user": {
                "userId": "69db714f-9576-45ba-b5b7-f00649be03de",
                "fullName": null,
                "userName": "hkhansh27",
                "email": "khanh200111@gmail.com"
            },
            "timestamp": "2022-10-13T16:22:10.5902507",
            "child": [
                {
                    "commentId": 3,
                    "parentId": 2,
                    "content": "Tin tuc ki thi cung phai doc roi vote nhe",
                    "newsId": 7245,
                    "user": {
                      "userId": "69db714f-9576-45ba-b5b7-f00649be03de",
                      "fullName": null,
                      "userName": "hkhansh27",
                      "email": "khanh200111@gmail.com"
                     },
                    "userId": "69db714f-9576-45ba-b5b7-f00649be03de",
                    "timestamp": "2022-10-13T16:22:37.2355535",
                    "child": []
                }
            ]
        }
 */

import 'package:fake_news/models/users/user_model.dart';

class CommentModel {
  String? commentId;
  String? parentId;
  String? content;
  String? newsId;
  String? userId;
  UserModel? user;
  String? timestamp;
  List<CommentModel>? child;

  CommentModel({
    this.commentId,
    this.parentId,
    this.content,
    this.newsId,
    this.userId,
    this.user,
    this.timestamp,
    this.child,
  });

  CommentModel.fromJson(Map<String, dynamic> json) {
    commentId = json["commentId"]?.toString();
    parentId = json["parentId"]?.toString();
    content = json["content"]?.toString();
    newsId = json["newsId"]?.toString();
    userId = json["userId"]?.toString();
    timestamp = json["timestamp"]?.toString();
    user = UserModel.fromJson(json["user"]);
    if (json["child"] != null) {
      child = List<CommentModel>.from(json["child"].map((x) => CommentModel.fromJson(x)));
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["commentId"] = commentId;
    data["parentId"] = parentId;
    data["content"] = content;
    data["newsId"] = newsId;
    data["userId"] = userId;
    data["timestamp"] = timestamp;
    data["user"] = user?.toJson();
    data["child"] = child == null ? null : List<dynamic>.from(child!.map((x) => x.toJson()));
    return data;
  }
}
