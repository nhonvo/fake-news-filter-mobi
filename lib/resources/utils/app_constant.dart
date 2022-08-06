class AppConstant {
  static SuccessMessage sucessmessage = SuccessMessage();
  static ErrorMessage errorMessage = ErrorMessage();
  static SharePrefKeys sharePrefKeys = SharePrefKeys();
  static MessageKey messageKey = MessageKey();
  static LocaleKey localeKey = LocaleKey();
  static AppKey appKey = AppKey();
  static const String resetPassPath = 'reset-password';
  static const String resetPassQuery = 'code';
}

class SuccessMessage {}

class ErrorMessage {
  final String emailInvalid = 'Email Invalid';
  final String passwordInvalid = 'Password Invalid';
  final String anErrorOccured = 'An error occured';
  final String invalidAccess = 'Your access is invalid';
  final String expiredAccess = 'Your access is expired, please login again';
  String badInternetConnection =
      'The internet connection appears to be offline, please try again';
}

class AppKey {
  final String newAppointment = 'new_appointment';
  final String pendingAppointment = 'pending_appointment';
  final String upcomingAppointment = 'upcoming_appointment_reminder';
  final String rescheduleAppointment = 'rescheduled_appointment';
  final String thankYouForVisiting = 'thank_you_for_visiting';
  final String cancelAppointment = 'cancelled_appointment';
  final String notShowAppointment = 'did_not_show_up';
  final String refund = 'refund';
}

class SharePrefKeys {
  final String apiKey = 'apiKey';
  final String deviceToken = 'deviceToken';
  final String authToken = 'authToken';
  final String userId = 'userId';
  final String firstName = 'firstName';
  final String lastName = 'lastName';
  final String email = 'email';
  final String listOrdersKey = 'listOrder';
  final String language = "language";
  final String phone = 'phone';
  final String countryCode = 'countryCode';
  final String avatar = 'avatar';
  final String isViewGuide = 'isViewGuide';
  final String startDayOfWeek = 'startDayOfWeek';
  final String formatTime = 'startDayOfWeek';
  final String taxes = 'taxes';
  final String isNotFollow = 'isNotFollow';
  final String languageContent = 'languageContent';
  final String appName = 'appName';
  final String packageName = 'packageName';
  final String version = 'version';
  final String buildNumber = 'buildNumber';
}

class LocaleKey {
  static const String EN = "en";
  static const String VI = "vi";
  static const String AR = "ar";
}

class MessageKey {
  final String messageKey = "messages";
  final String senderId = "senderId";
  final String receivedId = "receivedId";
  final String content = "content";
  final String lastMessages = "lastMessages";
  final String roomId = "roomId";
  final String timestamp = "timeStamp";
  final String type = "type";
  final String textType = "TEXT";
  final String imageType = "IMAGE";
}

class SizeConstant {
  static double maxWebWidth = 500.0;
}

class LocationContant {
  static double lat = 45.521563;
  static double long = -122.677433;
  static String address = '';
}
