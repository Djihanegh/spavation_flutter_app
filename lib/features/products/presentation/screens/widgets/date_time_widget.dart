import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/core/utils/app_styles.dart';
import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/core/widgets/app_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../app/theme.dart';
import '../../../../../../core/utils/size_config.dart';
import '../../../../../../generated/assets.dart';
import '../../../../../core/utils/format_date.dart';
import '../../../../localization/presentation/bloc/language_bloc.dart';
import '../../../data/models/product_model.dart';
import '../../bloc/product_bloc.dart';
import 'time_container.dart';

class DateTimeWidget extends StatefulWidget {
  const DateTimeWidget({super.key, required this.product});

  final ProductModel product;

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

  int days = 0;
  String selectedTime = '', actualHour = '', dayFrom = '', dayTo = '';

  List<DateTime> inactiveDates = [];
  List<String> activeDays = [];
  List<int> times = [];
  List<String> daysOfWeek = [
    'saturday',
    'sunday',
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday'
  ];

  int daysInMonth(DateTime date) {
    var firstDayThisMonth = DateTime(date.year, date.month, date.day);
    var firstDayNextMonth = DateTime(firstDayThisMonth.year,
        firstDayThisMonth.month + 1, firstDayThisMonth.day);
    return firstDayNextMonth.difference(firstDayThisMonth).inDays;
  }

  @override
  void initState() {
    actualHour = DateFormat('hh').format(DateFormat('hh').parse('${now.hour}'));

    timeTo = convertStringToHourMnSec(widget.product.timeTo);
    timeFrom = convertStringToHourMnSec(widget.product.timeFrom);

    int lastDay = daysInMonth(dateFrom);

    dateFrom = DateTime(now.year, now.month, 1);
    dateTo = DateTime(now.year, now.month, lastDay);

    dayFrom = widget.product.dateFrom.toLowerCase();
    dayTo = widget.product.dateTo.toLowerCase();

    int firstIndex = daysOfWeek.indexOf(dayFrom);
    int lastIndex = daysOfWeek.indexOf(dayTo);

    for (var i = firstIndex; i <= lastIndex; i++) {
      activeDays.add(daysOfWeek[i]);
    }

    log(timeTo.hour.toString());

    for (var i = timeFrom.hour; i <= timeTo.hour; i++) {
      times.add(i);
    }

    log(times.toString());

    days = daysBetween(dateFrom, dateTo);

    for (var i = 0; i <= days + 1; i++) {
      DateTime actual = DateTime.now().toUtc();
      DateTime date = DateTime(actual.year, actual.month, i + 1);
      String day = DateFormat('EEEE').format(date);

      if (dateFrom.day + i < now.day ||
          !activeDays.contains(day.toLowerCase())) {
        inactiveDates.add(dateFrom.add(Duration(days: i)));
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
        child: BlocConsumer<LanguageBloc, LanguageState>(
            listener: (context, language) {},
            buildWhen: (prev, curr) =>
                prev.selectedLanguage != curr.selectedLanguage,
            builder: (context, language) {
              return BlocConsumer<ProductBloc, ProductState>(
                  listener: (context, state) {},
                  buildWhen: (prev, curr) =>
                      prev.selectedDate != curr.selectedDate ||
                      prev.selectedTime != curr.selectedTime ||
                      prev.reservations != curr.reservations,
                  builder: (context, state) {
                    getSelectedDateBySalon(state);
                    getSelectedTimeBySalon(state);

                    return Column(mainAxisSize: MainAxisSize.min, children: [
                      Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.cancel,
                              color: appPrimaryColor,
                            ),
                          )),
                      AutoSizeText(
                        l10n.date,
                        style: TextStyles.inter.copyWith(
                            color: red[2], fontWeight: FontWeight.w700),
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
                                initialSelectedDate:
                                    selectedDate ?? DateTime.now(),
                                selectionColor: appPrimaryColor,
                                selectedTextColor: Colors.white,
                                daysCount: days + 1,
                                inactiveDates: inactiveDates,
                                deactivatedColor: grey[0],
                                locale: language
                                    .selectedLanguage.value.languageCode,
                                width: 60,
                                onDateChange: (date) {
                                  String day = DateFormat('EEEE').format(date);
                                  if ((date.day > DateTime.now().day &&
                                          activeDays
                                              .contains(day.toLowerCase())) ||
                                      date.day == DateTime.now().day) {
                                    // New date selected
                                    setState(() {
                                      selectedDate = date;
                                    });

                                    if (selectedDate != null) {
                                      context.read<ProductBloc>().add(
                                          SelectDate(
                                              selectedDate!,
                                              widget.product.id,
                                              widget.product.salonId));
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
                        l10n.time,
                        style: TextStyles.inter.copyWith(
                            color: red[2], fontWeight: FontWeight.w700),
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
                                for (var i = 0; i < times.length - 1; i++)
                                  GestureDetector(
                                      onTap: () {
                                        selectedTime =
                                            '${times[i]} - ${times[i + 1]}';
                                        context.read<ProductBloc>().add(
                                            SelectTime(
                                                selectedTime,
                                                widget.product.id,
                                                widget.product.salonId));
                                      },
                                      child: TimeContainer(
                                        isSelected: selectedTime ==
                                                '${times[i]} - ${times[i + 1]}'
                                            ? true
                                            : false,
                                        isDisabled:
                                            int.parse(actualHour) > times[i]
                                                ? false

                                                /// TRUE
                                                : false,
                                        startTime: times[i],
                                        endTime: times[i + 1],
                                      )),
                              ])),
                      20.heightXBox,
                      AppButton(
                        title: l10n.continueX,
                        color: appPrimaryColor,
                        textColor: Colors.white,
                        onPressed: () {
                          if (context.read<ProductBloc>().state.selectedTime !=
                                  null &&
                              context.read<ProductBloc>().state.selectedDate !=
                                  null) {
                            context
                                .read<ProductBloc>()
                                .add(SelectProduct(widget.product));
                          }

                          Navigator.pop(context);
                        },
                      ),
                      20.heightXBox
                    ]);
                  });
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

  void getSelectedDateBySalon(ProductState state) {
    if (state.reservations != null) {
      bool exists = state.reservations!.containsKey(widget.product.salonId);
      if (exists) {
        List<DataMap>? products = state.reservations![widget.product.salonId];

        DataMap? product;

        if (products != null) {
          product = products.firstWhere(
              (element) => element['id'] == widget.product.id,
              orElse: () => {});
        }

        if (product != null && product != {}) {
          selectedDate = product['date'];
        }
      }
    }
  }

  void getSelectedTimeBySalon(ProductState state) {
    if (state.reservations != null) {
      bool exists = state.reservations!.containsKey(widget.product.salonId);
      if (exists) {
        List<DataMap>? products = state.reservations![widget.product.salonId];

        DataMap? product;

        if (products != null) {
          product = products.firstWhere(
              (element) => element['id'] == widget.product.id,
              orElse: () => {});
        }

        if (product != null && product != {}) {
          selectedTime = product['time'] ?? '';
        }
      }
    }
  }
}
