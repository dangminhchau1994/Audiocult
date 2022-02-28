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
}
