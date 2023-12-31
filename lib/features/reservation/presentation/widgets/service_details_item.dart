import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:spavation/features/localization/presentation/bloc/language_bloc.dart';

import '../../../../app/theme.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/format_date.dart';
import '../../../../core/utils/typedef.dart';
import '../../../../generated/assets.dart';
import '../../../products/presentation/bloc/product_bloc.dart';

class ServiceDetailsItem extends StatefulWidget {
  const ServiceDetailsItem(
      {super.key,
      required this.productName,
      required this.productPrice,
      required this.selectedDate,
      required this.selectedTime,
      required this.productId,
      required this.salonId});

  final String productName;
  final String productPrice;
  final DateTime selectedDate;
  final String selectedTime;
  final String productId;
  final String salonId;

  @override
  State<ServiceDetailsItem> createState() => _ServiceDetailsItemState();
}

class _ServiceDetailsItemState extends State<ServiceDetailsItem> {
  String formattedDate = '';
  String time = '';
  DateTime? date;

  void getDate() {
    Future<String> localDate = getLocalDate(date ?? DateTime.now(),
        context.read<LanguageBloc>().state.selectedLanguage.value.languageCode);

    localDate.then((String result) {
      setState(() {
        formattedDate = result;
      });
    });
  }

  @override
  void initState() {
    Map<String, List<DataMap>>? reservations =
        context.read<ProductBloc>().state.reservations;

    if (reservations != null) {
      if (reservations.containsKey(widget.salonId)) {
        List<DataMap>? data = reservations[widget.salonId];
        if (data != null) {
          int index = data.indexWhere(
              (element) => element['id'] == int.parse(widget.productId));

          if (index != -1) {
            time = data[index]['time'];
            date = data[index]['date'];
          }
        }
      }
    }

    getDate();
    //formattedDate = getSelectedDate(date ?? DateTime.now(),
    //  context.read<LanguageBloc>().state.selectedLanguage.value.languageCode);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {},
        buildWhen: (prev, curr) => prev.reservations != curr.reservations,
        builder: (context, state) {
          return Column(
            children: [
              const Divider(
                color: dividerColor,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    widget.productName,
                    style: TextStyles.inter
                        .copyWith(color: purple[1], fontSize: 15),
                  ),
                  AutoSizeText(
                    '${widget.productPrice} ${l10n.sr}',
                    style: TextStyles.inter
                        .copyWith(color: appPrimaryColor, fontSize: 15),
                  )
                ],
              ),
              5.heightXBox,
              Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(Assets.iconsIonicIosCalendar),
                      5.widthXBox,
                      AutoSizeText(
                        formattedDate,
                        // getSelectedDate(
                        //   date ?? DateTime.now(), l10n.localeName),
                        style: TextStyles.inter
                            .copyWith(color: purple[1], fontSize: 15),
                      )
                    ],
                  )),
              Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        Assets.iconsClock,
                        width: 20,
                        height: 20,
                      ),
                      5.widthXBox,
                      AutoSizeText(
                        time, //  selectedTime,
                        style: TextStyles.inter
                            .copyWith(color: purple[1], fontSize: 15),
                      )
                    ],
                  )),
              10.heightXBox,
            ],
          );
        });
  }
}
