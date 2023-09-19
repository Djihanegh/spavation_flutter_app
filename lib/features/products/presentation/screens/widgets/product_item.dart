import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../app/theme.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/utils/size_config.dart';
import '../../../../../../generated/assets.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(
      {super.key,
      required this.description,
      required this.name,
      required this.price});

  final String description;
  final String name;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(left: sw! * 0.038, top: 10, bottom: 0),
            child: AutoSizeText(name,
                style:
                    TextStyles.inter.copyWith(color: purple[2], fontSize: 15))),
        Padding(
            padding: EdgeInsets.only(left: sw! * 0.035, bottom: 0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                      width: sw! * 0.75,
                      child: AutoSizeText(description,
                          style: TextStyles.inter
                              .copyWith(color: purple[2], fontSize: 15))),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(Assets.iconsAdd),
                      AutoSizeText('$price SR',
                          style: TextStyles.inter
                              .copyWith(color: purple[3], fontSize: 15))
                    ],
                  ),
                ]))
      ],
    );
  }
}
