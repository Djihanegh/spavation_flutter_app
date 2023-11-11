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
import '../../../../../core/utils/constant.dart';
import '../../../../../core/utils/format_date.dart';
import '../../../../localization/presentation/bloc/language_bloc.dart';
import '../../../data/models/product_model.dart';
import '../../bloc/product_bloc.dart';
import 'cancel_icon.dart';
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
  List<String> timeIntervals = [];

  int daysInMonth(DateTime date) {
    var firstDayThisMonth = DateTime(date.year, date.month, date.day);
    var firstDayNextMonth = DateTime(firstDayThisMonth.year,
        firstDayThisMonth.month + 1, firstDayThisMonth.day);
    return firstDayNextMonth.difference(firstDayThisMonth).inDays;
  }

  @override
  void initState() {
    actualHour = DateFormat('hh').format(DateFormat('hh').parse('${now.hour}'));
    getNumberOfDays();
    getActiveDays();
    getInactiveDates();
    getSelectedDateBySalon(context.read<ProductBloc>().state);
    getSelectedTimeBySalon(context.read<ProductBloc>().state);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
        child: BlocConsumer<ProductBloc, ProductState>(
            listener: (context, state) => _onStateListenHandler(state: state),
            buildWhen: (prev, curr) =>
                prev.selectedDate != curr.selectedDate ||
                prev.selectedTime != curr.selectedTime ||
                prev.reservations != curr.reservations,
            builder: (context, state) {
              return Column(mainAxisSize: MainAxisSize.min, children: [
                const CancelIcon(),
                AutoSizeText(
                  l10n.date,
                  style: TextStyles.inter
                      .copyWith(color: red[2], fontWeight: FontWeight.w700),
                ),
                10.heightXBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    l10n.localeName == 'en'
                        ? GestureDetector(
                            onTap: () => setDateAndAnimateTo('-'),
                            child: SvgPicture.asset(Assets.iconsPrevious))
                        : GestureDetector(
                            onTap: () => setDateAndAnimateTo('-'),
                            child: SvgPicture.asset(Assets.iconsNext)),
                    SizedBox(
                        height: 100,
                        width: sw! * 0.5,
                        child: DatePicker(
                          DateTime.now(),
                          controller: _pickerController,
                          selectionColor: appPrimaryColor,
                          selectedTextColor: Colors.white,
                          daysCount: days + 1,
                          inactiveDates: inactiveDates,
                          deactivatedColor: grey[0],
                          locale: l10n.localeName,
                          width: 60,
                          onDateChange: (date) => _selectDate(date),
                        )),
                    l10n.localeName == 'en'
                        ? GestureDetector(
                            onTap: () => setDateAndAnimateTo('+'),
                            child: SvgPicture.asset(Assets.iconsNext))
                        : GestureDetector(
                            onTap: () => setDateAndAnimateTo('+'),
                            child: SvgPicture.asset(Assets.iconsPrevious)),
                  ],
                ),
                20.heightXBox,
                AutoSizeText(
                  l10n.time,
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
                          for (var i = 0; i < timeIntervals.length - 1; i++)
                            GestureDetector(
                                onTap: () => _selectTime(i),
                                child: TimeContainer(
                                  isSelected: selectedTime == timeIntervals[i],
                                  isDisabled: false,
                                  time: timeIntervals[i],
                                )),
                        ])),
                20.heightXBox,
                AppButton(
                    isLoading: false,
                    title: l10n.continueX,
                    color: appPrimaryColor,
                    textColor: Colors.white,
                    onPressed: () => _continue()),
                20.heightXBox
              ]);
            }));
  }

  void getNumberOfDays() {
    int lastDay = daysInMonth(dateFrom);
    dateFrom = DateTime(now.year, now.month, 1);
    dateTo = DateTime(now.year, now.month, lastDay);
    days = daysBetween(dateFrom, dateTo);
  }

  void getActiveDays() {
    dayFrom = widget.product.dateFrom.toLowerCase();
    dayTo = widget.product.dateTo.toLowerCase();

    int firstIndex = daysOfWeek.indexOf(dayFrom);
    int lastIndex = daysOfWeek.indexOf(dayTo);
    for (var i = firstIndex; i <= lastIndex; i++) {
      activeDays.add(daysOfWeek[i]);
    }
  }

  void getInactiveDates() {
    for (var i = 0; i <= days + 1; i++) {
      DateTime actual = DateTime.now().toUtc();
      DateTime date = DateTime(actual.year, actual.month, i + 1);
      String day = DateFormat('EEEE').format(date);

      if (dateFrom.day + i < now.day ||
          !activeDays.contains(day.toLowerCase())) {
        inactiveDates.add(dateFrom.add(Duration(days: i)));
      }
    }
  }

  void _selectTime(int i) {
    setState(() {
      selectedTime = timeIntervals[i];

      context.read<ProductBloc>().add(
          SelectTime(selectedTime, widget.product.id, widget.product.salonId));
    });
  }

  void _onStateListenHandler({required ProductState state}) {
    if (state.timeIntervals != null ) {
      setState(() {
        timeIntervals = state.timeIntervals ?? [];
      });
    }
  }

  void _selectDate(DateTime date) {
    String day = DateFormat('EEEE').format(date);
    if ((date.day > DateTime.now().day &&
            activeDays.contains(day.toLowerCase())) ||
        date.day == DateTime.now().day) {
      // New date selected

      setState(() {
        selectedDate = date;
      });

      if (selectedDate != null) {
        context.read<ProductBloc>().add(GetProductTimesEvent(
            "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}",
            widget.product.id));

        context.read<ProductBloc>().add(SelectDate(
            selectedDate!, widget.product.id, widget.product.salonId));
      }
    }
  }

  void _continue() {
    if (context.read<ProductBloc>().state.selectedTime != null &&
        context.read<ProductBloc>().state.selectedDate != null) {
      context.read<ProductBloc>().add(SelectProduct(widget.product));
    }

    Navigator.pop(context);
  }

  String getStartAndEndTime(int startTime, int endTime, var l10n) {
    String timeA =
        '${startTime <= 12 ? "$startTime ${l10n.am}" : "$startTime ${l10n.pm}"} ';
    String timeB =
        '${endTime <= 12 ? "$endTime ${l10n.am}" : "$endTime ${l10n.pm}"} ';

    String selectedTime = "$timeA - $timeB";

    return selectedTime;
  }

  DateTime scrolledTime = DateTime.now();

  void setDateAndAnimateTo(String operator) {
    if (selectedDate != null) {
      if (operator == '+') {
        setState(() {
          DateTime date = DateTime(scrolledTime.year, scrolledTime.month,
              scrolledTime.day + 1); //DateTime(

          scrolledTime = date;

          Future.delayed(const Duration(milliseconds: 2), () {
            _pickerController.animateToDate(date);
            //setDateAndAnimate(date);
          });
        });
      } else {
        setState(() {
          DateTime date = DateTime(
              scrolledTime.year, scrolledTime.month, scrolledTime.day - 1);
          scrolledTime = date;
          Future.delayed(const Duration(milliseconds: 2), () {
            _pickerController.animateToDate(date);
          });
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
