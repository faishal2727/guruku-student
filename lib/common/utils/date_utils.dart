import 'package:intl/intl.dart';

String formatDate(String dateStr) {
  DateTime dateTime = DateTime.parse(dateStr);
  return DateFormat('dd MMM yyyy, HH:mm').format(dateTime);
}
