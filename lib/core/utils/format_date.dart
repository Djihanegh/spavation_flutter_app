import 'dart:developer';

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

String getHourMnSec(String timeTo) {
  return DateFormat("hh:mm a").format(DateFormat('hh:mm:ss').parseUtc(timeTo));
}

DateTime convertStringToHourMnSec(String time) {
  return DateFormat("HH:mm:ss").parse(time);
}

DateTime convertStringToDateTime(String time) {
  return DateFormat("yyyy-MM-dd").parse(time);
}

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}

String getSelectedDate(DateTime date, String language) {
  Future<String> localDate = getLocalDate(date, language);
  String formattedDate = '';
  localDate.then((String result) {
    formattedDate = result;
  });

  return formattedDate;
}

Future<String> getLocalDate(DateTime date, String language) async {
  String localDate = '';
  String localCode = '';

  language == 'en' ? localCode = "en_US" : localCode = "ar_SA";

  await initializeDateFormatting(localCode, null).then((_) {
    localDate =
        DateFormat.yMMMd(localCode).format(date); //('EEEE').format(date);

    log(localDate);
  });

  return localDate;
}
