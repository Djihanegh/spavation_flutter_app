import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/core/utils/app_styles.dart';

import '../../../../../../app/theme.dart';
import '../../../../../../core/utils/size_config.dart';
import '../../../../../../generated/assets.dart';
import '../../../../../core/utils/format_date.dart';
import 'time_container.dart';

class DateTimeWidget extends StatefulWidget {
  const DateTimeWidget(
      {super.key,
      required this.timeTo,
      required this.timeFrom,
      required this.dateTo,
      required this.dateFrom});

  final String timeTo;
  final String timeFrom;
  final String dateTo;
  final String dateFrom;

  @override
  State<DateTimeWidget> createState() => _DateTimeWidgetState();
}

class _DateTimeWidgetState extends State<DateTimeWidget> {
  final DatePickerController _pickerController = DatePickerController();
  DateTime selectedDate = DateTime.now(),
      timeTo = DateTime.now(),
      timeFrom = DateTime.now(),
      dateTo = DateTime.now(),
      dateFrom = DateTime.now();

  List<int> times = [];
  int days = 0;

  @override
  void initState() {
    timeTo = convertStringToHourMnSec(widget.timeTo);
    timeFrom = convertStringToHourMnSec(widget.timeFrom);

    dateTo = convertStringToDateTime(widget.dateTo);
    dateFrom = convertStringToDateTime(widget.dateFrom);

    for (var i = timeFrom.hour; i < timeTo.hour; i++) {
      times.add(i);
    }

    days = daysBetween(dateFrom, dateTo);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
      Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.cancel,
              color: appPrimaryColor,
            ),
          )),
      AutoSizeText(
        'Date',
        style: TextStyles.inter
            .copyWith(color: red[2], fontWeight: FontWeight.w700),
      ),
      10.heightXBox,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: () => setDateAndAnimateTo('-'),
              child: SvgPicture.asset(Assets.iconsPrevious)),
          SizedBox(
              height: 100,
              width: sw! * 0.5,
              child: DatePicker(
                dateFrom,
                controller: _pickerController,
                initialSelectedDate: DateTime.now(),
                selectionColor: appPrimaryColor,
                selectedTextColor: Colors.white,
                daysCount: days + 1,
                width: 60,
                onDateChange: (date) {
                  // New date selected
                  setState(() {
                    selectedDate = date;
                  });
                },
              )),
          GestureDetector(
              onTap: () => setDateAndAnimateTo('+'),
              child: SvgPicture.asset(Assets.iconsNext)),
        ],
      ),
      20.heightXBox,
      AutoSizeText(
        'Time',
        style: TextStyles.inter
            .copyWith(color: red[2], fontWeight: FontWeight.w700),
      ),
      10.heightXBox,
      SizedBox(
          width: sw!,
          child: Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: [
                for (var i = 0; i < (times.length / 2); i++)
                  TimeContainer(
                    isSelected: true,
                    isDisabled: false,
                    startTime: times[i],
                    endTime: times[i + 1],
                  ),
              ]))
    ]));
  }

  void setDateAndAnimateTo(String operator) {
    if (operator == '+') {
      setState(() {
        DateTime date = DateTime(
            selectedDate.year, selectedDate.month, selectedDate.day + 1);

        selectedDate = date;

        _pickerController.setDateAndAnimate(date);
        _pickerController.jumpToSelection();
      });
    } else {
      setState(() {
        DateTime date = DateTime(
            selectedDate.year, selectedDate.month, selectedDate.day - 1);
        selectedDate = date;
        _pickerController.setDateAndAnimate(date);
        _pickerController.jumpToSelection();
      });
    }
  }
}
