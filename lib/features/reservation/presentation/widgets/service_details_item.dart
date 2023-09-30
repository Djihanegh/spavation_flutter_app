import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';

import '../../../../app/theme.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/format_date.dart';
import '../../../../generated/assets.dart';

class ServiceDetailsItem extends StatelessWidget {
  const ServiceDetailsItem(
      {super.key,
      required this.productName,
      required this.productPrice,
      required this.selectedDate,
      required this.selectedTime});

  final String productName;
  final String productPrice;
  final DateTime selectedDate;
  final String selectedTime;

  @override
  Widget build(BuildContext context) {
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
              style: TextStyles.inter.copyWith(color: purple[1], fontSize: 15),
            ),
            AutoSizeText(
              '$productPrice SR',
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
                  getSelectedDate(selectedDate),
                  style:
                      TextStyles.inter.copyWith(color: purple[1], fontSize: 15),
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
                  selectedTime,
                  style:
                      TextStyles.inter.copyWith(color: purple[1], fontSize: 15),
                )
              ],
            )),
        10.heightXBox,
      ],
    );
  }
}
