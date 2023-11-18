import 'dart:developer';

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

String getHourMnSec(String timeTo) {
  String date = '';
  try {
    date =
        DateFormat("hh:mm a").format(DateFormat('hh:mm:ss').parseUtc(timeTo));
  } catch (e) {
    log(e.toString());
  }
  return date;
}

DateTime convertStringToHourMnSec(String time) {
  DateTime date = DateTime.now();
  try {
    date = DateFormat("HH:mm:ss").parse(time);
  } catch (e) {
    log(e.toString());
  }
  return date;
}

DateTime convertStringToDateTime(String time) {
  DateTime date = DateTime.now();
  try {
    date = DateFormat("yyyy-MM-dd").parse(time);
  } catch (e) {
    log(e.toString());
  }
  return date;
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
