import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/core/utils/app_styles.dart';

import '../../../../../../app/theme.dart';
import '../../../../../../core/utils/size_config.dart';
import '../../../../../../generated/assets.dart';
import '../../../../../core/utils/format_date.dart';
import '../../bloc/product_bloc.dart';
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
  DateTime timeTo = DateTime.now(),
      timeFrom = DateTime.now(),
      dateTo = DateTime.now(),
      dateFrom = DateTime.now(),
      now = DateTime.now();

  DateTime? selectedDate = DateTime.now();

  List<int> times = [];
  int days = 0;
  String selectedTime = '';
  String actualHour = '';
  List<DateTime> inactiveDates = [];

  @override
  void initState() {
    actualHour = DateFormat('hh').format(DateFormat('hh').parse('${now.hour}'));

    timeTo = convertStringToHourMnSec(widget.timeTo);
    timeFrom = convertStringToHourMnSec(widget.timeFrom);

    dateTo = convertStringToDateTime(widget.dateTo);
    dateFrom = convertStringToDateTime(widget.dateFrom);

    for (var i = timeFrom.hour; i < timeTo.hour; i++) {
      times.add(i);
    }

    days = daysBetween(dateFrom, dateTo);

    for (var i = 0; i < days + 1; i++) {
      if (dateFrom.day + i < DateTime.now().day) {
        // DateTime date = dateFrom.
        inactiveDates.add(dateFrom.add(Duration(days: i)));
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: BlocConsumer<ProductBloc, ProductState>(
            listener: (context, state) {},
            listenWhen: (prev, curr) =>
                prev.selectedDate != curr.selectedDate ||
                prev.selectedTime != curr.selectedTime,
            buildWhen: (prev, curr) =>
                prev.selectedDate != curr.selectedDate ||
                prev.selectedTime != curr.selectedTime,
            builder: (context, state) {
              if (state.selectedDate != null) {
                selectedDate = state.selectedDate;
              }
              if (state.selectedTime != '' && state.selectedTime != null) {
                selectedTime = state.selectedTime ?? '';
              }
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
                          dateFrom,
                          controller: _pickerController,
                          initialSelectedDate: selectedDate ?? DateTime.now(),
                          selectionColor: appPrimaryColor,
                          selectedTextColor: Colors.white,
                          daysCount: days + 1,
                          inactiveDates: inactiveDates,
                          deactivatedColor: grey[0],
                          width: 60,
                          onDateChange: (date) {
                            if ((date.day > DateTime.now().day) ||
                                date.day == DateTime.now().day) {
                              // New date selected
                              setState(() {
                                selectedDate = date;
                              });

                              if (selectedDate != null) {
                                context
                                    .read<ProductBloc>()
                                    .add(SelectDate(selectedDate!));
                              }
                            }
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
                            GestureDetector(
                                onTap: () {
                                  if (int.parse(actualHour) < times[i]) {
                                    selectedTime =
                                        '${times[i]} - ${times[i + 1]}';
                                    context
                                        .read<ProductBloc>()
                                        .add(SelectTime(selectedTime));
                                  }
                                },
                                child: TimeContainer(
                                  isSelected: selectedTime ==
                                          '${times[i]} - ${times[i + 1]}'
                                      ? true
                                      : false,
                                  isDisabled: int.parse(actualHour) > times[i]
                                      ? true
                                      : false,
                                  startTime: times[i],
                                  endTime: times[i + 1],
                                )),
                        ]))
              ]);
            }));
  }

  void setDateAndAnimateTo(String operator) {
    if (selectedDate != null) {
      if (operator == '+') {
        setState(() {
          DateTime date = DateTime(
              selectedDate!.year, selectedDate!.month, selectedDate!.day + 1);

          selectedDate = date;

          _pickerController.setDateAndAnimate(date);
          _pickerController.jumpToSelection();
        });
      } else {
        setState(() {
          DateTime date = DateTime(
              selectedDate!.year, selectedDate!.month, selectedDate!.day - 1);
          selectedDate = date;
          _pickerController.setDateAndAnimate(date);
          _pickerController.jumpToSelection();
        });
      }
    }
  }
}
