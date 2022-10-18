import 'package:fake_news/core/api/auth_api.dart';
import 'package:fake_news/core/api/comment_api.dart';
import 'package:fake_news/core/api/dio_api.dart';
import 'package:fake_news/core/api/extra_api.dart';
import 'package:fake_news/core/api/following_api.dart';
import 'package:fake_news/core/api/language_api.dart';
import 'package:fake_news/core/api/news_api.dart';
import 'package:fake_news/core/api/news_community_api.dart';
import 'package:fake_news/core/api/topic_api.dart';
import 'package:fake_news/core/api/update_api.dart';
import 'package:fake_news/core/api/vote_api.dart';
import 'package:fake_news/services/language_service/language_service.dart';
import 'package:fake_news/core/services/local_storage/local_storage.dart';
import 'package:fake_news/providers/local_storage_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppServices {
  static Future<void> initServices() async {
    print('Starting services ...');
    await Get.putAsync<SharedPreferences>(() async {
      return await SharedPreferences.getInstance();
    });
    await Get.putAsync(() async {
      return await LanguageService(sharedPreferences: Get.find()).init();
    });
    Get.put<LocalStorage>(LocalStorageIpml(sharedPref: Get.find()));
    Get.put<LocalStorageRepo>(LocalStorageRepoImpl(localStorage: Get.find()));
    Get.put<DioApi>(DioApi(localRepo: Get.find()));
    Get.put<UpdateApi>(UpdateApiImpl(dioApi: Get.find()));
    Get.put<AuthApi>(AuthApiIpml(dioApi: Get.find()));
    Get.put<TopicApi>(TopicApiIpml(dioApi: Get.find()));
    Get.put<NewsApi>(NewsApiIpml(dioApi: Get.find()));
    Get.put<LanguageApi>(LanguageApiImpl(dioApi: Get.find()));
    Get.put<FollowingApi>(FollowingApiImpl(dioApi: Get.find()));
    Get.put<VoteApi>(VoteApiImpl(dioApi: Get.find()));
    Get.put<NewsCommunityApi>(NewsCommunityApiImpl(dioApi: Get.find()));
    Get.put<CommentApi>(CommentApiImpl(dioApi: Get.find()));
    Get.put<ExtraApi>(ExtraApiImpl(dioApi: Get.find()));

    print('All services started! ✅');
  }
}
