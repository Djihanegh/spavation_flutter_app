import 'package:intl/intl.dart';

String getHourMnSec(String timeTo) {
  return DateFormat("hh:mm a").format(DateFormat('hh:mm:ss').parseUtc(timeTo));
}

DateTime convertStringToDateTime(String time) {
  return DateFormat("hh:mm:ss").parse(time);
}
