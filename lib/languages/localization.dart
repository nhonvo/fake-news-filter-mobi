import 'package:fake_news/resources/utils/app_constant.dart';
import 'package:get/get.dart';

import 'language_key.dart';

class Localization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        LocaleKey.EN: {
          LanguageKey.appname: 'Fake News Filter',
          LanguageKey.language: 'English',
          LanguageKey.klanguage: 'Language',
          LanguageKey.managelanguage: 'LANGUAGE MANAGERMENT',
          LanguageKey.displaylanguage: 'Select your display language',
          LanguageKey.contentlanguage:
              'What language do you want to read news?',
          LanguageKey.login: 'Login',
          LanguageKey.hello: 'Hello',
          LanguageKey.translate: 'Translate',
          LanguageKey.started: 'Get started',
          LanguageKey.inputuser: 'Input username or email',
          LanguageKey.inputpass: 'Input password',
          LanguageKey.inputUserEmptyErr: 'Username or email cannot be empty',
          LanguageKey.inputPassEmptyErr: 'Password cannot be empty',
          LanguageKey.inputPassAtLeast6Err:
              'Password must be at least 6 characters',
          LanguageKey.or: 'or',
          LanguageKey.help: 'Help you?',
          LanguageKey.agree: 'I agree to ',
          LanguageKey.terms: 'The terms and Conditions ',
          LanguageKey.about: 'of Fake News Filter',
          LanguageKey.introduction:
              'Follow top stories and get key update in one place, posted live. Without clickbait or junk.',
          LanguageKey.covering: 'What we are covering',
          LanguageKey.content_started:
              'Follow feeds to track new updates and get notifications. We will let you know when we create new ones.',
          LanguageKey.tap: 'Tap to choose at least 4',
          LanguageKey.multipleLanguage: 'Multiple language',
          LanguageKey.breaking: 'Breaking',
          LanguageKey.fake: 'Fake news',
          LanguageKey.real: 'Real news',
          LanguageKey.home: 'Home',
          LanguageKey.news: 'News',
          LanguageKey.search: 'Search',
          LanguageKey.profile: 'Profile',
          LanguageKey.reliable: 'Is the reliable news?',
          LanguageKey.hours: 'hours',
          LanguageKey.fa: 'Fake',
          LanguageKey.re: 'Real',
          LanguageKey.copy: 'Copy link',
          LanguageKey.browser: 'Open in browser',
          LanguageKey.error_browser: 'Error when opening in browser',
          LanguageKey.clipboard: 'Copied link to your clipboard!',
          LanguageKey.altMessage: 'An error occurred',
          LanguageKey.error: 'Error',
          LanguageKey.loadingLogin: "Logging in...",
          LanguageKey.fetchingData: "Fetching data...",
          LanguageKey.fetchingDataErr: "Error when fetching data",
          LanguageKey.dataConvertErr: "Error when converting data",
          LanguageKey.requestTimeOutErr: "Your request time out",
          LanguageKey.noInternetErr:
              "The internet connection appears to be offline, please try again",
          LanguageKey.serverErr: "Server error, please try again, code:",
          LanguageKey.serverDieErr: "Server is die, please try again",
          LanguageKey.interruptErr: "Cancelled, please try again",
          LanguageKey.updateProfile: "Update profile",
          LanguageKey.followTopic: "Change follow topic",
          LanguageKey.linkSocial: "Link social network",
          LanguageKey.rateApp: "Rate application",
        },
        LocaleKey.VI: {
          LanguageKey.appname: 'Fake News Filter',
          LanguageKey.language: 'Tiếng Việt',
          LanguageKey.klanguage: 'Ngôn ngữ',
          LanguageKey.managelanguage: 'QUẢN LÝ NGÔN NGỮ',
          LanguageKey.displaylanguage: 'Chọn ngôn ngữ hiển thị',
          LanguageKey.contentlanguage:
              'Bạn muốn đọc tin tức bằng ngôn ngữ nào?',
          LanguageKey.login: 'Đăng nhập',
          LanguageKey.hello: 'Xin chào',
          LanguageKey.translate: 'Chuyển đổi ngôn ngữ',
          LanguageKey.started: 'Khám phá',
          LanguageKey.inputuser: 'Nhập tên đăng nhập hoặc email',
          LanguageKey.inputpass: 'Nhập mật khẩu',
          LanguageKey.inputUserEmptyErr:
              'Tên đăng nhập hoặc email không được để trống',
          LanguageKey.inputPassEmptyErr: 'Mật khẩu không được để trống',
          LanguageKey.inputPassAtLeast6Err: 'Mật khẩu phải có ít nhất 6 ký tự',
          LanguageKey.or: 'hoặc',
          LanguageKey.help: 'Cần giúp đỡ?',
          LanguageKey.agree: 'Tôi đồng ý với ',
          LanguageKey.terms: 'Điều khoản sử dụng ',
          LanguageKey.about: 'của Fake News Filter',
          LanguageKey.introduction:
              'Theo dõi những tin tức nằm ở những chủ đề khác nhau.',
          LanguageKey.covering: 'Tổng hợp chủ đề được quan tâm',
          LanguageKey.content_started:
              'Theo dõi các chủ đề để thông báo. Ứng dụng sẽ cho bạn biết khi hệ thống có những cập nhật mới',
          LanguageKey.tap: 'Chọn ít nhất 4 chủ đề',
          LanguageKey.multipleLanguage: 'Đa ngôn ngữ',
          LanguageKey.breaking: 'Xu hướng',
          LanguageKey.fake: 'Tin giả',
          LanguageKey.real: 'Tin thật',
          LanguageKey.home: 'Trang chủ',
          LanguageKey.news: 'Tin tức',
          LanguageKey.search: 'Tìm kiếm',
          LanguageKey.profile: 'Tài khoản',
          LanguageKey.hours: 'giờ',
          LanguageKey.reliable: 'Tin tức đáng tin cậy?',
          LanguageKey.fa: 'Không',
          LanguageKey.re: 'Có',
          LanguageKey.copy: 'Sao chép đường dẫn',
          LanguageKey.browser: 'Mở bằng trình duyệt',
          LanguageKey.error_browser: 'Không thể mở bằng trình duyệt',
          LanguageKey.clipboard: 'Đã sao chép đường dẫn bài báo!',
          LanguageKey.altMessage: 'Có lỗi xảy ra',
          LanguageKey.error: 'Lỗi',
          LanguageKey.loadingLogin: "Đang đăng nhập...",
          LanguageKey.fetchingData: "Đang tải dữ liệu...",
          LanguageKey.fetchingDataErr: "Lỗi khi tải dữ liệu",
          LanguageKey.dataConvertErr: "Lỗi khi chuyển dữ liệu",
          LanguageKey.requestTimeOutErr: "Yêu cầu của bạn đã hết thời gian",
          LanguageKey.noInternetErr:
              "Kết nối internet của bạn bị lỗi, vui lòng thử lại",
          LanguageKey.serverErr: "Lỗi máy chủ, vui lòng thử lại, mã lỗi:",
          LanguageKey.serverDieErr: "Máy chủ đã bị lỗi, vui lòng thử lại",
          LanguageKey.interruptErr: "Đã hủy, vui lòng thử lại",
          LanguageKey.updateProfile: "Cập nhật thông tin cá nhân",
          LanguageKey.followTopic: "Thay đổi Chủ đề tin tức",
          LanguageKey.linkSocial: "Liên kết mạng xã hội",
          LanguageKey.rateApp: "Đã hủy, vui lòng thử lại",
        },
      };
}
