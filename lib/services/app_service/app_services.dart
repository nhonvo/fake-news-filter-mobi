import 'package:fake_news/core/api/auth_api.dart';
import 'package:fake_news/core/api/dio_api.dart';
import 'package:fake_news/core/api/topic_api.dart';
import 'package:fake_news/core/services/language_service.dart';
import 'package:fake_news/core/services/local_storage/auth_local_storage.dart';
import 'package:fake_news/providers/auth_repo.dart';
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
    // await Get.putAsync(() async {
    //   return LocationService();
    // });
    Get.put<AuthLocalStorage>(AuthLocalStorageIpml(sharedPref: Get.find()));
    Get.put<AuthRepo>(AuthRepoImpl(authLocalStorage: Get.find()));
    Get.put<DioApi>(DioApi(authRepo: Get.find()));
    Get.put<AuthApi>(AuthApiIpml(dioApi: Get.find()));
    Get.put<TopicApi>(TopicApiIpml(dioApi: Get.find()));
    // Get.put<AppointmentApi>(AppointmentApiIpml(dioApi: Get.find()));
    // Get.put<ServicePackageApi>(ServicePackageApiImpl(dioApi: Get.find()));
    // Get.put<FirebaseMessagingWrapper>(
    //     FirebaseMessagingImp(preferences: Get.find()));
    // Get.put<NotificationApi>(MessageApiImpl(dioApi: Get.find()));
    // Get.put<ClientApi>(ClientApiIpml(dioApi: Get.find()));
    // Get.put<RankApi>(RankApiImpl(dioApi: Get.find()));
    // Get.put<PaymentApi>(PaymentApiImpl(dioApi: Get.find()));
    print('All services started! ✅');
  }

  static Future<void> initTestServices() async {
    print('Starting services ...');
    await Get.putAsync<SharedPreferences>(() async {
      return await SharedPreferences.getInstance();
    });
    await Get.putAsync<LanguageService>(() async {
      return await LanguageService(sharedPreferences: Get.find()).init();
    });
    // Get.put<AuthLocalStorage>(AuthLocalStorageIpml(sharedPref: Get.find()));
    // Get.put<AuthRepo>(AuthRepoImpl(authLocalStorage: Get.find()));
    // Get.put<DioApi>(DioApi(authRepo: Get.find()));
    // //Get.put<AuthApi>(FakeAuthApiIpml());

    print('All test services started! ✅');
  }
}
