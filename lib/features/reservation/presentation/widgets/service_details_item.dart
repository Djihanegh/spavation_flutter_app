import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../app/theme.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/format_date.dart';
import '../../../../core/utils/typedef.dart';
import '../../../../generated/assets.dart';
import '../../../products/presentation/bloc/product_bloc.dart';

class ServiceDetailsItem extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {},
        buildWhen: (prev, curr) => prev.reservations != curr.reservations,
        builder: (context, state) {
          String time = '';
          DateTime? date;

          Map<String, List<DataMap>>? reservations = state.reservations;

          if (reservations != null) {
            if (reservations.containsKey(salonId)) {
              List<DataMap>? data = reservations[salonId];
              if (data != null) {
                int index = data.indexWhere(
                    (element) => element['id'] == int.parse(productId));

                if (index != -1) {
                  time = data[index]['time'];
                  date = data[index]['date'];
                }
              }
            }
          }
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
                    productName,
                    style: TextStyles.inter
                        .copyWith(color: purple[1], fontSize: 15),
                  ),
                  AutoSizeText(
                    '$productPrice ${l10n.sr}',
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
                        getSelectedDate(date ?? DateTime.now()),
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
