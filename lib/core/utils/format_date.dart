import 'package:intl/intl.dart';

String getHourMnSec(String timeTo) {
  return DateFormat("hh:mm a").format(DateFormat('hh:mm:ss').parseUtc(timeTo));
}

DateTime convertStringToHourMnSec(String time) {
  return DateFormat("hh:mm:ss").parse(time);
}

DateTime convertStringToDateTime(String time) {

  DateTime date = DateTime.now();
  return DateFormat("yyyy-MM-dd").parse(time);
}

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}

String getSelectedDate(DateTime date) {
  return DateFormat('d MMM y').format(date);
}
