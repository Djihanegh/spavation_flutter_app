import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/core/utils/app_styles.dart';

import '../../../../../app/theme.dart';
import '../../../../../core/utils/size_config.dart';
import '../../../../../core/widgets/custom_back_button.dart';
import '../../../../../generated/assets.dart';
import 'widgets/service_item.dart';

class ServiceDetailsScreen extends StatefulWidget {
  const ServiceDetailsScreen({super.key});

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    screenSizeInit(context);
    return Scaffold(
        backgroundColor: appPrimaryColor,
        body: Center(
            child: Stack(alignment: Alignment.center, children: [
          Padding(
              padding: EdgeInsets.only(top: sh! * 0.2),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomBackButton(),
                      ],
                    ),
                    10.heightXBox,
                    Container(
                        height: sh! * 0.25,
                        width: sw! * 0.95,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(15)),
                        child: Stack(
                          children: [
                            Positioned(
                                top: 3,
                                left: sw! * 0.2,
                                child: const CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.white,
                                )),
                            Container(
                                height: sh! * 0.25,
                                width: sw! * 0.95,
                                margin: paddingAll(10),
                                decoration: BoxDecoration(
                                    boxShadow: boxShadow,
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Stack(
                                  children: [
                                    Positioned(
                                        right: sw! * 0.03,
                                        top: 0,
                                        child: Column(
                                          children: [
                                            SvgPicture.asset(
                                                Assets.iconsIonicIosBookmark),
                                            AutoSizeText(
                                              '10%',
                                              style: TextStyles.montserrat
                                                  .copyWith(
                                                      color: red[0],
                                                      fontWeight:
                                                          FontWeight.w300),
                                            )
                                          ],
                                        )),
                                    Positioned(
                                        right: sw! * 0.2,
                                        top: sh! * 0.01,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AutoSizeText(
                                              'SPA Ways',
                                              style: TextStyles.inter.copyWith(
                                                  color: appPrimaryColor,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                                height: sh! * 0.2,
                                                width: sw! * 0.4,
                                                child: AutoSizeText(
                                                  'Provide personalized services  to each client to enhance their natural beauty',
                                                  style: TextStyles.montserrat
                                                      .copyWith(
                                                          color:
                                                              appPrimaryColor,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w300),
                                                ))
                                          ],
                                        )),

                                    Positioned(
                                        left: sw! * 0.05,
                                        top: sh! * 0.15,
                                        child: SizedBox(
                                            width: sw! * 0.8,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Image.asset(
                                                    Assets.iconsAwesomeFemale,
                                                    color: appPrimaryColor),
                                                Image.asset(
                                                    Assets.iconsAwesomeMale,
                                                    color: appPrimaryColor),
                                                const Icon(
                                                  Icons.home_filled,
                                                  color: appPrimaryColor,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Icon(
                                                      Icons.location_on,
                                                      color: appPrimaryColor,
                                                    ),
                                                    AutoSizeText(
                                                      '1.5k.m',
                                                      style: TextStyles.inter
                                                          .copyWith(
                                                              fontSize: 7,
                                                              color:
                                                                  appPrimaryColor),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      Assets.iconsClock,
                                                      height: 20,
                                                      width: 20,
                                                    ),
                                                    AutoSizeText(
                                                      'Close At 11PM',
                                                      // Close At 11PM
                                                      style: TextStyles.inter
                                                          .copyWith(
                                                              fontSize: 6,
                                                              color:
                                                                  appPrimaryColor),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ))),

                                    Positioned(
                                        left: 0,
                                        top: sh! * 0.2,
                                        child: Container(
                                          color: dividerColor,
                                          width: sw!,
                                          height: 1,
                                        ))

                                    ///
                                  ],
                                )),
                            Positioned(
                                left: sw! * 0.07,
                                top: 2.4,
                                child: Container(
                                  height: sh! * 0.09,
                                  width: sw! * 0.165,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: boxShadow,
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(5),
                                          bottomRight: Radius.circular(5),
                                          topLeft: Radius.circular(5))),
                                  child: Image.asset(Assets.iconsSpaLogo),
                                ))
                          ],
                        )),
                    Container(
                        height: sh! * 0.4,
                        width: sw! * 0.9,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                10.heightXBox,
                                RichText(
                                  text: TextSpan(
                                    // text: 'Hello ',
                                    style: DefaultTextStyle.of(context).style,
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'All',
                                          style: TextStyles.inter.copyWith(
                                              color: red[2], fontSize: 15)),
                                      TextSpan(
                                          text:
                                              ' Hair Nails Massage Hair Nails Massage ',
                                          style: TextStyles.inter.copyWith(
                                              color: appFilterCoLOR,
                                              fontSize: 15)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                    height: sh! * 0.36,
                                    width: sw!,
                                    child: ListView.builder(
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        itemCount: 9,
                                        itemBuilder: (context, index) =>
                                            const ServiceItem())),
                              ],
                            ),
                            Positioned(
                                bottom: 0,
                                child: Container(
                                  height: 40,
                                  width: sw! * 0.9,
                                  decoration: BoxDecoration(
                                      color: grey[0],
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20))),
                                  child: Padding(
                                      padding:
                                         const  EdgeInsets.only(left: 10, right: 10),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          AutoSizeText(
                                            'Services details',
                                            style: TextStyles.inter.copyWith(
                                                color: Colors.white,
                                                fontSize: 15),
                                          ),
                                          AutoSizeText('Riyal',
                                              style: TextStyles.inter.copyWith(
                                                  color: Colors.white,
                                                  fontSize: 15))
                                        ],
                                      )),
                                ))
                          ],
                        ))
                  ])),
          Positioned(
              top: -10,
              left: -25,
              child: Container(
                height: sh! * 0.17,
                width: sw! * 0.35,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.35),
                    borderRadius: appCircular),
              )),
        ])));
  }
}
