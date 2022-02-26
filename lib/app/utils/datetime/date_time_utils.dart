import 'package:intl/intl.dart';

class DateTimeUtils {
  static DateTime convertTimeStampToDate(int timeStamp) {
    return DateTime.fromMicrosecondsSinceEpoch(timeStamp);
  }

  static String formatDate(String format, DateTime dateTime) {
    return DateFormat(format).format(dateTime);
  }
}
