import 'package:intl/intl.dart';

class DateTimeUtils {
  static String formatCommonDate(String format, int timeStamp) {
    final dateToTimeStamp = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    return DateFormat(format).format(dateToTimeStamp);
  }

  static String formatyMMMMd(int timeStamp) {
    final dateToTimeStamp = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    return DateFormat.yMMMMd().format(dateToTimeStamp);
  }

  static String convertToAgo(int timeStamp) {
    final diff = DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000));

    if (diff.inDays >= 1) {
      return '${diff.inDays} day(s) ago';
    } else if (diff.inHours >= 1) {
      return '${diff.inHours} hour(s) ago';
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes} minute(s) ago';
    } else if (diff.inSeconds >= 1) {
      return '${diff.inSeconds} second(s) ago';
    } else {
      return 'just now';
    }
  }
}
