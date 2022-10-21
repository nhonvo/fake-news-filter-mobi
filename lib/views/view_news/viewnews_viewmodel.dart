import 'package:fake_news/core/api/comment_api.dart';
import 'package:fake_news/core/api/topic_api.dart';
import 'package:fake_news/core/base/base_view_model.dart';
import 'package:fake_news/models/comment/comment_model.dart';
import 'package:fake_news/providers/local_storage_repo.dart';
import 'package:fake_news/resources/utils/app_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewNewsViewModel extends BaseViewModel {
  ViewNewsViewModel({
    required this.localRepo,
    required this.prefs,
    required this.commentApi,
  });

  LocalStorageRepo localRepo;
  SharedPreferences prefs;
  CommentApi commentApi;

  final comList = <CommentModel>[].obs;
  var isLoading = true.obs;
  var commentId = "".obs;

  TextEditingController textCommentController = TextEditingController();

  getCommentInNews(String newsId) async {
    var response = await commentApi.getCommentsInNews(newsId);
    if (response != null) {
      List<CommentModel> result = response.resultObj?.obs ?? [];
      comList.clear();
      comList.addAll(result);
      isLoading.value = false;
    }
  }

  addComment(String newsId) async {
    var userId = await localRepo.getUserId();
    var response = await commentApi.addComment(
      userId!,
      newsId,
      textCommentController.text,
      commentId.value == "" ? '0' : commentId.value,
    );

    if (response.statusCode == 200) {
      textCommentController.clear();
      var parentId = int.parse(response.resultObj!.parentId!);
      if (parentId != 0) {
        comList.firstWhere((e) => e.commentId == response.resultObj?.parentId).child?.add(response.resultObj!);
      } else {
        comList.add(response.resultObj!);
      }
      comList.refresh();
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClosed() {
    super.onClose();
  }
}
