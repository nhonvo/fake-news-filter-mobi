import 'package:get/get_utils/src/extensions/internacionalization.dart';

class AppHelper {
  static String convertToAgo(DateTime input) {
    Duration diff = DateTime.now().difference(input);
    if (diff.inDays >= 1) {
      if (diff.inDays >= 31) {
        return '${diff.inDays ~/ 31} ${'months'.tr} ${'ago'.tr}';
      } else {
        return '${diff.inDays} ${'days'.tr} ${'ago'.tr}';
      }
    } else if (diff.inHours >= 1) {
      return '${diff.inHours} ${'hours'.tr} ${'ago'.tr}';
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes} ${'minutes'.tr} ${'ago'.tr}';
    } else if (diff.inSeconds >= 1) {
      return '${diff.inSeconds} ${'seconds'.tr} ${'ago'.tr}';
    } else {
      return '${'now'.tr}';
    }
  }
}
