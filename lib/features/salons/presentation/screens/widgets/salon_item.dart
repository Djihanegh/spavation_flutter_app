import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/core/utils/endpoint.dart';
import 'package:spavation/core/utils/navigation.dart';
import 'package:spavation/features/home/presentation/screens/service_details/service_details_screen.dart';
import 'package:spavation/features/salons/presentation/screens/widgets/salon_loadig_widget.dart';

import '../../../../../app/theme.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/constant.dart';
import '../../../../../core/utils/size_config.dart';
import '../../../../../generated/assets.dart';

class SalonItem extends StatelessWidget {
  const SalonItem(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.isForFemale,
      required this.isForMale,
      required this.rate,
      required this.distance,
      required this.image});

  final String title;
  final String subtitle;
  final String isForFemale;
  final String isForMale;
  final String rate;
  final String distance;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => navigateToPage(const ServiceDetailsScreen(), context),
        child: Padding(
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
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: Image.network(
                                    Endpoints.storageUrl + image,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return const SalonShimmer();
                                    },
                                    errorBuilder:
                                        ((context, error, stackTrace) =>
                                            SizedBox(
                                                width: sw! * 0.99,
                                                height: sh! * 0.15,
                                                child: const Icon(Icons.error,
                                                    color: Colors.black))),
                                    fit: BoxFit.cover,
                                  ).image),
                              borderRadius: BorderRadius.circular(5),
                              color: appDarkBlue),
                        ),
                        10.widthXBox,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              title,
                              style: TextStyles.inter
                                  .copyWith(color: headerTextColor),
                            ),
                            AutoSizeText(subtitle,
                                style: TextStyles.montserrat),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                50.widthXBox,
                                isForFemale == '1'
                                    ? Image.asset(Assets.iconsAwesomeFemale)
                                    : emptyWidget(),
                                5.widthXBox,
                                isForMale == '1'
                                    ? Image.asset(Assets.iconsAwesomeMale)
                                    : emptyWidget(),
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
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      padding: const EdgeInsets.only(
                                          right: 10, top: 0),

                                      //padding: const EdgeInsets.only(left: 10, right: 10),
                                      itemCount: stars.length,
                                      itemBuilder: (context, index) =>
                                          stars[index]))),
                          const Spacer(),
                          AutoSizeText(
                            distance.length > 6
                                ? '${'${distance.split('.')[0]}.${distance.split('.')[1].substring(0, 2)}'} km'
                                : '$distance k.m',
                            style: TextStyles.inter
                                .copyWith(fontSize: 18, color: headerTextColor),
                            softWrap: true,
                            maxLines: 4,
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
                    color: appPrimaryColor,
                    height: 2,
                    width: sw! * 0.72,
                  )
                ],
              )
            ])));
  }
}

double rating = 0.0;

Widget buildStar(
  BuildContext context,
  int index,
) {
  Icon icon;
  if (index >= rating) {
    icon = const Icon(
      Icons.star,
      color: appYellowColor,
    );
  } else if (index > rating - 1 && index < rating) {
    icon = const Icon(
      Icons.star_half,
      color: appYellowColor,
    );
  } else {
    icon = const Icon(
      Icons.star,
      color: appStarGrey,
    );
  }
  return InkResponse(
    onTap: onRatingChanged == null ? null : () => onRatingChanged(index + 1.0),
    child: icon,
  );
}

void onRatingChanged(double rating) {}

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