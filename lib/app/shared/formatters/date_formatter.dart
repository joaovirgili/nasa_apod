import 'package:intl/intl.dart';

class DateFormatter {
  static String format(DateTime date) => DateFormat.yMd().format(date);
}
