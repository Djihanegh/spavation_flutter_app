import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/core/utils/endpoint.dart';
import 'package:spavation/core/utils/navigation.dart';
import 'package:spavation/core/widgets/loading_widget.dart';
import 'package:spavation/features/products/presentation/screens/products_screen.dart';
import 'package:spavation/features/salons/presentation/screens/widgets/salon_loadig_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      required this.image,
      required this.salonId,
      required this.taxRate,
      required this.taxNumber});

  final String title;
  final String subtitle;
  final bool isForFemale;
  final bool isForMale;
  final String rate;
  final String distance;
  final String image;
  final String salonId;
  final String taxRate;
  final String taxNumber;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return GestureDetector(
        onTap: () => navigateToPage(
            ProductsScreen(
              salonId: salonId,
              isForFemale: isForFemale,
              isForMale: isForMale,
              distance: distance,
              name: title,
              description: subtitle,
              image: image,
              taxRate: taxRate,
              taxNumber: taxNumber,
            ),
            context),
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
                        CachedNetworkImage(
                            imageUrl: Endpoints.storageUrl + image,
                            placeholder: (context, url) =>
                                const LoadingWidget(),
                            errorWidget: (context, url, error) =>
                                const SizedBox(
                                    height: 60,
                                    width: 60,
                                    child:
                                        Icon(Icons.error, color: Colors.black)),
                            imageBuilder: (context, imageProvider) => Container(
                                  height: 60,
                                  width: 60,
                                  margin: paddingAll(3),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: imageProvider,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors
                                          .grey), /* Image.network(
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
                                  ).image */
                                )),
                        10.widthXBox,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              title.toLowerCase(),
                              style: TextStyles.inter
                                  .copyWith(color: headerTextColor),
                            ),
                            SizedBox(
                                width: 150,
                                child: AutoSizeText(subtitle,
                                    overflow: TextOverflow.ellipsis,
                                    minFontSize: 12,
                                    maxLines: 1,
                                    style: TextStyles.montserrat)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                50.widthXBox,
                                isForFemale == true
                                    ? Image.asset(Assets.iconsAwesomeFemale)
                                    : emptyWidget(),
                                5.widthXBox,
                                isForMale == true
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
                                      itemCount: int.parse(rate) <= 5
                                          ? int.parse(rate)
                                          : 5,
                                      itemBuilder: (context, index) =>
                                          stars[index]))),
                          const Spacer(),
                          AutoSizeText(
                            distance.length > 6
                                ? '${'${distance.split('.')[0]}.${distance.split('.')[1].substring(0, 2)}'} ${l10n.km}'
                                : '$distance ${l10n.km}',
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
    color: appYellowColor,
    size: 15,
  ),
];
