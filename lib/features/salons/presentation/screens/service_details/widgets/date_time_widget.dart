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
import 'time_container.dart';

class DateTimeWidget extends StatefulWidget {
  const DateTimeWidget({super.key});

  @override
  State<DateTimeWidget> createState() => _DateTimeWidgetState();
}

class _DateTimeWidgetState extends State<DateTimeWidget> {
  final DatePickerController _pickerController = DatePickerController();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
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
                DateTime.now(),
                controller: _pickerController,
                initialSelectedDate: DateTime.now(),
                selectionColor: appPrimaryColor,
                selectedTextColor: Colors.white,
                daysCount: 500,
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
          child: const Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 10,
            children: [
              TimeContainer(
                isSelected: true,
                isDisabled: false,
                startTime: 10,
                endTime: 11,
              ),
              TimeContainer(
                  isSelected: false,
                  isDisabled: false,
                  startTime: 11,
                  endTime: 12),
              TimeContainer(
                  isSelected: false,
                  isDisabled: true,
                  startTime: 12,
                  endTime: 13),
              TimeContainer(
                  isSelected: false,
                  isDisabled: false,
                  startTime: 13,
                  endTime: 14),
              TimeContainer(
                  isSelected: false,
                  isDisabled: false,
                  startTime: 14,
                  endTime: 15),
              TimeContainer(
                  isSelected: false,
                  isDisabled: false,
                  startTime: 15,
                  endTime: 16),
            ],
          ))
    ]);
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
