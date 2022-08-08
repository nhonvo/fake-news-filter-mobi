import 'package:fake_news/resources/utils/app_constant.dart';
import 'package:get/get.dart';

import 'language_key.dart';

class Localization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        LocaleKey.EN: {
          LanguageKey.appname: 'Owl Trust',
          LanguageKey.slogan: 'Fake News Filter',
          LanguageKey.language: 'English',
          LanguageKey.klanguage: 'Language',
          LanguageKey.managelanguage: 'LANGUAGE MANAGERMENT',
          LanguageKey.displaylanguage: 'Select your display language',
          LanguageKey.contentlanguage:
              'What language do you want to read news?',
          LanguageKey.login: 'Login',
          LanguageKey.hello: 'Hello',
          LanguageKey.logout: 'Logout',
          LanguageKey.translate: 'Translate',
          LanguageKey.started: 'Get started',
          LanguageKey.inputuser: 'Input username or email',
          LanguageKey.inputpass: 'Input password',
          LanguageKey.inputName: 'Input your name',
          LanguageKey.inputEmail: 'Input email',
          LanguageKey.inputPhone: 'Input phone number',
          LanguageKey.inputPassConfirm: 'Input password confirm',
          LanguageKey.inputUserEmptyErr: 'Username or email cannot be empty',
          LanguageKey.inputPassEmptyErr: 'Password cannot be empty',
          LanguageKey.inputPassAtLeast6Err:
              'Password must be at least 6 characters',
          LanguageKey.or: 'or',
          LanguageKey.help: 'Help you?',
          LanguageKey.okay: 'Okay',
          LanguageKey.cancel: 'Cancel',
          LanguageKey.confirmLogout: 'Are you sure you want to logout?',
          LanguageKey.agree: 'I agree to ',
          LanguageKey.terms: 'The terms and Conditions ',
          LanguageKey.about: 'of Fake News Filter',
          LanguageKey.introduction:
              'Follow top stories and get key update in one place, posted live. Without clickbait or junk.',
          LanguageKey.covering: 'What we are covering',
          LanguageKey.content_started:
              'Follow feeds to track new updates and get notifications. We will let you know when we create new ones.',
          LanguageKey.tap: 'Tap to choose at least 4',
          LanguageKey.read_more: 'Read more',
          LanguageKey.multipleLanguage: 'Multiple language',
          LanguageKey.breaking: 'Breaking',
          LanguageKey.filter_news: "Filter news",
          LanguageKey.choose_type_filter: "Choose type of news to filter",
          LanguageKey.fake: 'Fake news',
          LanguageKey.real: 'Real news',
          LanguageKey.home: 'Home',
          LanguageKey.news: 'News',
          LanguageKey.community: 'Community',
          LanguageKey.profile: 'Profile',
          LanguageKey.reliable: 'Is the reliable news?',
          LanguageKey.days: 'day(s)',
          LanguageKey.hours: 'hour(s)',
          LanguageKey.minutes: 'minutes',
          LanguageKey.seconds: 'seconds',
          LanguageKey.ago: 'ago',
          LanguageKey.now: 'now',
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
          LanguageKey.voting: "Voting...",
          LanguageKey.searchNews: "Search news...",
          LanguageKey.config: "Settings",
          LanguageKey.aboutFnf: "About Fake News Filter",
          LanguageKey.version: "",
          LanguageKey.support: "Support",
          LanguageKey.checkVerify: "Check verify",
          LanguageKey.sendInfo: "Send info",
          LanguageKey.addFile: "Add an attachment",
          LanguageKey.viewGuide: "Guide",
          LanguageKey.highlightContributedNews: "Highlight contributed news",
          LanguageKey.newContributedNews: "New contributed news",
          LanguageKey.skip: "Skip",
          LanguageKey.next: "Next",
          LanguageKey.done: "Done",
          LanguageKey.onboardTitle1: "READING NEWS",
          LanguageKey.onboardTitle2: "NEWS CONFIRMED",
          LanguageKey.onboardTitle3: "INTERACT WITH NEWS",
          LanguageKey.onboardTitle4: "GET NEW NOTIFICATIONS",
          LanguageKey.onboardBody1:
              "Diverse topics and languages. \nRead news based on the topics you follow.",
          LanguageKey.onboardBody2:
              "The fake news will be filtered and shown specifically in each news, avoiding unreliable news.",
          LanguageKey.onboardBody3:
              "Users can vote, share, comment or contribute to the authenticity of the news.",
          LanguageKey.onboardBody4:
              "The new news will be updated to achieve the best experience for users.",
          LanguageKey.allowNotification: "Allow notification",
          LanguageKey.haveUpdateVersion: "A new version is avaiable"
        },
        LocaleKey.VI: {
          LanguageKey.appname: 'Owl Trust',
          LanguageKey.slogan: 'Fake News Filter',
          LanguageKey.language: 'Tiếng Việt',
          LanguageKey.klanguage: 'Ngôn ngữ',
          LanguageKey.managelanguage: 'QUẢN LÝ NGÔN NGỮ',
          LanguageKey.displaylanguage: 'Chọn ngôn ngữ hiển thị',
          LanguageKey.contentlanguage:
              'Bạn muốn đọc tin tức bằng ngôn ngữ nào?',
          LanguageKey.login: 'Đăng nhập',
          LanguageKey.logout: 'Đăng xuất',
          LanguageKey.hello: 'Xin chào',
          LanguageKey.translate: 'Chuyển đổi ngôn ngữ',
          LanguageKey.started: 'Khám phá',
          LanguageKey.inputuser: 'Nhập tên đăng nhập hoặc email',
          LanguageKey.inputpass: 'Nhập mật khẩu',
          LanguageKey.inputName: 'Nhập tên của bạn',
          LanguageKey.inputEmail: 'Nhập email',
          LanguageKey.inputPhone: 'Nhập số điện thoại',
          LanguageKey.inputPassConfirm: 'Nhập lại mật khẩu',
          LanguageKey.inputUserEmptyErr:
              'Tên đăng nhập hoặc email không được để trống',
          LanguageKey.inputPassEmptyErr: 'Mật khẩu không được để trống',
          LanguageKey.inputPassAtLeast6Err: 'Mật khẩu phải có ít nhất 6 ký tự',
          LanguageKey.or: 'hoặc',
          LanguageKey.help: 'Cần giúp đỡ?',
          LanguageKey.okay: 'Đồng ý',
          LanguageKey.cancel: 'Hủy',
          LanguageKey.confirmLogout: 'Bạn có chắc chắn muốn đăng xuất?',
          LanguageKey.agree: 'Tôi đồng ý với ',
          LanguageKey.terms: 'Điều khoản sử dụng ',
          LanguageKey.about: 'của Fake News Filter',
          LanguageKey.introduction:
              'Theo dõi những tin tức nằm ở những chủ đề khác nhau.',
          LanguageKey.covering: 'Tổng hợp chủ đề được quan tâm',
          LanguageKey.content_started:
              'Theo dõi các chủ đề để thông báo. Ứng dụng sẽ cho bạn biết khi hệ thống có những cập nhật mới',
          LanguageKey.tap: 'Chọn ít nhất 4 chủ đề',
          LanguageKey.read_more: 'Xem thêm',
          LanguageKey.multipleLanguage: 'Đa ngôn ngữ',
          LanguageKey.breaking: 'Xu hướng',
          LanguageKey.filter_news: "Lọc tin tức",
          LanguageKey.choose_type_filter: "Chọn loại tin tức cần lọc",
          LanguageKey.fake: 'Tin giả',
          LanguageKey.real: 'Tin thật',
          LanguageKey.home: 'Trang chủ',
          LanguageKey.news: 'Tin tức',
          LanguageKey.community: 'Cộng đồng',
          LanguageKey.profile: 'Cá nhân',
          LanguageKey.days: 'ngày',
          LanguageKey.hours: 'giờ',
          LanguageKey.minutes: 'phút',
          LanguageKey.seconds: 'giây',
          LanguageKey.ago: 'trước',
          LanguageKey.now: 'hiện tại',
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
          LanguageKey.rateApp: "Đánh giá ứng dụng",
          LanguageKey.voting: "Đang bình chọn...",
          LanguageKey.searchNews: "Tìm kiếm tin tức...",
          LanguageKey.config: "Cấu hình",
          LanguageKey.aboutFnf: "Về Fake News Filter",
          LanguageKey.version: "",
          LanguageKey.support: "Hỗ trợ",
          LanguageKey.checkVerify: "Kiểm tra tính xác thực",
          LanguageKey.sendInfo:
              "Gửi thông tin chi tiết về tin tức cần xác thực...",
          LanguageKey.addFile: "Thêm tệp đính kèm",
          LanguageKey.viewGuide: "Xem hướng dẫn",
          LanguageKey.highlightContributedNews: "Tin đóng góp nổi bật",
          LanguageKey.newContributedNews: "Tin đóng góp mới nhất",
          LanguageKey.skip: "Bỏ qua",
          LanguageKey.next: "Tiếp theo",
          LanguageKey.done: "Hoàn thành",
          LanguageKey.onboardTitle1: "XEM TIN TỨC",
          LanguageKey.onboardTitle2: "TIN TỨC ĐƯỢC XÁC THỰC",
          LanguageKey.onboardTitle3: "TƯƠNG TÁC TRÊN TIN TỨC",
          LanguageKey.onboardTitle4: "NHẬN THÔNG BÁO MỚI",
          LanguageKey.onboardBody1:
              "Đa dạng các chủ đề, ngôn ngữ. \nĐọc các tin tức dựa trên chủ đề đã theo dõi.",
          LanguageKey.onboardBody2:
              "Các tin tức giả sẽ được lọc và thể hiện cụ thể ở từng tin tức, tránh các tin không đáng tin cậy.",
          LanguageKey.onboardBody3:
              "Người dùng có thể bình chọn, chia sẻ, bình luận hoặc đóng góp tính xác thực của các tin tức.",
          LanguageKey.onboardBody4:
              "Các tin tức mới sẽ được cập nhật để đạt trải nghiệm tốt nhất cho người dùng.",
          LanguageKey.allowNotification: "Cho phép gửi thông báo",
          LanguageKey.haveUpdateVersion: "Đã có bản cập nhật mới"
        },
      };
}
