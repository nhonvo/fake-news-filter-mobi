class AppHelper {
  static String convertToAgo(DateTime input) {
    Duration diff = DateTime.now().difference(input);
    if (diff.inDays >= 1) {
      if (diff.inDays >= 31) {
        return '${diff.inDays ~/ 31} months ago';
      } else {
        return '${diff.inDays} days ago';
      }
    } else if (diff.inHours >= 1) {
      return '${diff.inHours} hour(s)';
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes} minute(s)';
    } else if (diff.inSeconds >= 1) {
      return '${diff.inSeconds} second(s)';
    } else {
      return 'just now';
    }
  }
}
