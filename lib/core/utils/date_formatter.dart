import 'package:intl/intl.dart';

class DateFormatter {
  static String format(String date) {
    try {
      final parsedDate = DateTime.parse(date);
      return DateFormat('MMMM dd, yyyy').format(parsedDate);
    } catch (e) {
      return date;
    }
  }
}
