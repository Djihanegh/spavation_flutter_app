import 'package:flutter/cupertino.dart';
import 'package:spavation/core/utils/typedef.dart';

//List<String> categories = <String>['Body Care', 'Massage', 'Hair', 'Nails'];

const List<String> genderEn = <String>['Male', 'Female'];
const List<String> genderAr = <String>['ذكر', 'أنثى'];

emptyWidget() => const SizedBox.shrink();

Map<String, String> headers = {
  'Content-Type': 'application/json',
  'Accept': 'application/json'
};

Map<String, String> headersWithToken(String token) {
  Map<String, String> header = headers;

  header['Authorization'] = 'Bearer $token';

  return header;
}

const forgetPasswordKey = Key('forget-password');

List<String> daysOfWeek = [
  'saturday',
  'sunday',
  'monday',
  'tuesday',
  'wednesday',
  'thursday',
  'friday'
];