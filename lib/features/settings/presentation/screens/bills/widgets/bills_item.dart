import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:spavation/app/theme.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/core/utils/format_date.dart';
import 'package:spavation/core/utils/navigation.dart';
import 'package:spavation/features/reservation/data/models/reservation_model.dart';

import '../../../../../../core/utils/app_styles.dart';
import '../bills_details_screen.dart';

class BillsItem extends StatelessWidget {
  const BillsItem({super.key, required this.reservationModel});

  final ReservationModel reservationModel;

  @override
  Widget build(BuildContext context) {
    DateTime date = convertStringToDateTime(reservationModel.createdAt);
    return GestureDetector(
        onTap: () => navigateToPage(
            BillsDetailsScreen(
              reservationModel: reservationModel,
            ),
            context),
        child: Padding(
            padding: paddingAll(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  reservationModel.salonName.isEmpty
                      ? 'Undefined'
                      : reservationModel.salonName,
                  style: TextStyles.montserrat.copyWith(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.start,
                ),
                5.heightXBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      '#${reservationModel.id}',
                      style: TextStyles.montserrat.copyWith(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w100),
                    ),
                    AutoSizeText(
                      '${date.day}/${date.month}/${date.year}',
                      style: TextStyles.montserrat.copyWith(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w100),
                    ),
                  ],
                ),
                5.heightXBox,
                const Divider(
                  color: Color(0xFFA899BB),
                )
              ],
            )));
  }
}
