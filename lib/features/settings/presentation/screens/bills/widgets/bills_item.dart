import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:spavation/app/theme.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';

import '../../../../../../core/utils/app_styles.dart';

class BillsItem extends StatelessWidget {
  const BillsItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: paddingAll(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              'SPA Woman',
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
                  '#100339',
                  style: TextStyles.montserrat.copyWith(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w100),
                ),
                AutoSizeText(
                  '12/02/2023',
                  style: TextStyles.montserrat.copyWith(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w100),
                ),
              ],
            ),
            5.heightXBox,

            Divider(color: Color(0xFFA899BB),)
          ],
        ));
  }
}
