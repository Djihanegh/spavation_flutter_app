import 'package:flutter/material.dart';
import 'package:spavation/core/utils/size_config.dart';

import 'date_time_widget.dart';

showDateTimeDialog({
  required BuildContext context,
  required String timeTo,
  required String timeFrom,
  required String dateTo,
  required String dateFrom,
}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            backgroundColor: Colors.white,
            shadowColor: Colors.white,
            surfaceTintColor: Colors.white,
            insetPadding: EdgeInsets.only(top: sh! * 0.35),
            scrollable: true,
            content: Container(
                width: sw! * 0.7,
                height: 320,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: DateTimeWidget(
                    timeTo: timeTo,
                    timeFrom: timeFrom,
                    dateFrom: dateFrom,
                    dateTo: dateTo)));
      });
}
