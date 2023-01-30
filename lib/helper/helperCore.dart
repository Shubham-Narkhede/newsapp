import 'package:intl/intl.dart';

class HelperCore {
  static String dateFormat(String format, DateTime dateTime) {
    return DateFormat(format).format(dateTime);
  }

  static String dateStringFormat(String format, String dateTime) {
    return DateFormat(format).format(DateTime.parse(dateTime)).toString();
  }
}
