import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';

import '../../../../app/theme.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../generated/assets.dart';

class ServiceItem extends StatelessWidget {
  const ServiceItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: paddingAll(5),
        child: Column(children: [
          Container(
            color: Colors.white,
            height: sh! * 0.104,
            padding: paddingAll(0),
            // color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      margin: paddingAll(3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: appDarkBlue),
                      child: Center(
                          child: AutoSizeText(
                        'LOGO',
                        style: TextStyles.inter
                            .copyWith(color: Colors.white, fontSize: 15),
                        textAlign: TextAlign.center,
                      )),
                    ),
                    10.widthXBox,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          'Special Salon',
                          style:
                              TextStyles.inter.copyWith(color: headerTextColor),
                        ),
                        AutoSizeText('Hair', style: TextStyles.montserrat),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            50.widthXBox,
                            Image.asset(Assets.iconsAwesomeFemale),
                            5.widthXBox,
                            Image.asset(Assets.iconsAwesomeMale),
                          ],
                        ),
                        10.heightXBox,
                      ],
                    ),
                  ],
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                          child: Align(
                              alignment: Alignment.topRight,
                              child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  padding:
                                      const EdgeInsets.only(right: 10, top: 0),

                                  //padding: const EdgeInsets.only(left: 10, right: 10),
                                  itemCount: stars.length,
                                  itemBuilder: (context, index) =>
                                      stars[index]))),
                      const Spacer(),
                      AutoSizeText(
                        '1.5 k.m',
                        style: TextStyles.inter
                            .copyWith(fontSize: 18, color: headerTextColor),
                      ),
                      const Spacer(),
                    ])
              ],
            ),
          ),
          Row(
            children: [
              Container(
                color: Colors.transparent,
                height: 2,
                width: sw! * 0.2,
              ),
              Container(
                color: appPurple,
                height: 2,
                width: sw! * 0.72,
              )
            ],
          )
        ]));
  }
}

List<Widget> stars = const [
  Icon(
    Icons.star,
    color: appYellowColor,
    size: 15,
  ),
  Icon(
    Icons.star,
    color: appYellowColor,
    size: 15,
  ),
  Icon(
    Icons.star,
    color: appYellowColor,
    size: 15,
  ),
  Icon(
    Icons.star,
    color: appYellowColor,
    size: 15,
  ),
  Icon(
    Icons.star,
    color: appStarGrey,
    size: 15,
  ),
];
