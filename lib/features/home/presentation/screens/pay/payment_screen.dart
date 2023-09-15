import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/core/widgets/app_button.dart';
import 'package:spavation/features/settings/presentation/screens/update_user/widgets/custom_text_field.dart';
import 'package:spavation/generated/assets.dart';

import '../../../../../app/theme.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/size_config.dart';
import '../../../../../core/widgets/custom_back_button.dart';
import '../filter/widgets/filter_choice_box.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    screenSizeInit(context);
    return Scaffold(
        backgroundColor: appPrimaryColor,
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(top: sh! * 0.15),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AutoSizeText(
                            '',
                            style: TextStyles.inter
                                .copyWith(color: Colors.white, fontSize: 15),
                          ),
                          AutoSizeText(
                            'Request Review',
                            style: TextStyles.inter
                                .copyWith(color: Colors.white, fontSize: 20),
                          ),
                          const Align(
                              alignment: Alignment.centerRight,
                              child: CustomBackButton()),
                        ],
                      ),
                      10.heightXBox,
                      Container(
                        //  height: sh! * 0.28,
                        width: sw! * 0.95,
                        margin: paddingAll(10),
                        padding: paddingAll(10),
                        decoration: BoxDecoration(
                            boxShadow: boxShadow,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            10.heightXBox,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(Assets.iconsMaterialDetails),
                                10.widthXBox,
                                AutoSizeText(
                                  'Services Details',
                                  style: TextStyles.inter.copyWith(
                                      color: appPrimaryColor, fontSize: 20),
                                )
                              ],
                            ),
                            const Divider(
                              color: dividerColor,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(
                                  '- Nails 2',
                                  style: TextStyles.inter
                                      .copyWith(color: purple[1], fontSize: 15),
                                ),
                                AutoSizeText(
                                  '75 SR',
                                  style: TextStyles.inter.copyWith(
                                      color: appPrimaryColor, fontSize: 15),
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
                                    SvgPicture.asset(
                                        Assets.iconsIonicIosCalendar),
                                    5.widthXBox,
                                    AutoSizeText(
                                      '12 Aug 2023',
                                      style: TextStyles.inter.copyWith(
                                          color: purple[1], fontSize: 15),
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
                                      '13 - 14',
                                      style: TextStyles.inter.copyWith(
                                          color: purple[1], fontSize: 15),
                                    )
                                  ],
                                )),
                            10.heightXBox,
                            AutoSizeText(
                              'Service For',
                              style: TextStyles.inter.copyWith(
                                  color: appPrimaryColor, fontSize: 20),
                            ),
                            const Divider(
                              color: dividerColor,
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      Assets.iconsAwesomeMale,
                                      color: appPrimaryColor,
                                    ),
                                    10.widthXBox,
                                    AutoSizeText(
                                      'Male',
                                      style: TextStyles.inter.copyWith(
                                          color: purple[1], fontSize: 15),
                                    ),
                                    20.widthXBox,
                                    Image.asset(
                                      Assets.iconsAwesomeFemale,
                                      color: appPrimaryColor,
                                    ),
                                    10.widthXBox,
                                    AutoSizeText(
                                      'Female',
                                      style: TextStyles.inter.copyWith(
                                          color: purple[1], fontSize: 15),
                                    )
                                  ],
                                )),
                          ],
                        ),
                      ),

                      Container(
                          // height: sh! * 0.15,
                          width: sw! * 0.95,
                          margin: paddingAll(10),
                          padding: paddingAll(10),
                          decoration: BoxDecoration(
                              boxShadow: boxShadow,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                10.heightXBox,
                                Row(children: [
                                  SvgPicture.asset(
                                    Assets.iconsMaterialPayment,
                                    colorFilter:  ColorFilter.mode(
                                        purple[1], BlendMode.srcIn)

                                  ),
                                  10.widthXBox,
                                  AutoSizeText(
                                    'Payment Type',
                                    style: TextStyles.inter.copyWith(
                                        color: appPrimaryColor, fontSize: 20),
                                  )
                                ]),
                                const Divider(
                                  color: dividerColor,
                                ),
                                Row(
                                  children: [
                                    const FilterChoiceBox(
                                      isSelected: true,
                                      title: '',
                                    ),
                                    5.widthXBox,
                                    SvgPicture.asset(
                                      Assets.iconsApple,
                                    ),
                                    5.widthXBox,
                                    AutoSizeText(
                                      'Pay with Apple',
                                      style: TextStyles.inter.copyWith(
                                          color: purple[1], fontSize: 15),
                                    )
                                  ],
                                ),
                                5.heightXBox,
                                Row(
                                  children: [
                                    const FilterChoiceBox(
                                      isSelected: false,
                                      title: '',
                                    ),
                                    5.widthXBox,
                                    SvgPicture.asset(Assets.iconsVisaCard),
                                    5.widthXBox,
                                    AutoSizeText(
                                      'Credit or Debit Card',
                                      style: TextStyles.inter.copyWith(
                                          color: purple[1], fontSize: 15),
                                    )
                                  ],
                                )
                              ])),

                      Container(
                          //  height: sh! * 0.1,
                          width: sw! * 0.95,
                          margin: paddingAll(10),
                          padding: paddingAll(10),
                          decoration: BoxDecoration(
                              boxShadow: boxShadow,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                              child: CustomTextFormField(
                            hintText: 'Discount code',
                            onSaved: () {},
                            padding: 0,
                          ))),
                      10.heightXBox,
                      Container(
                          //     height: sh! * 0.25,
                          width: sw! * 0.95,
                          margin: paddingAll(10),
                          padding: paddingAll(10),
                          decoration: BoxDecoration(
                              boxShadow: boxShadow,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                10.heightXBox,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                        Assets.iconsAwesomeFileInvoice),
                                    10.widthXBox,
                                    AutoSizeText(
                                      'Invoicement Details:',
                                      style: TextStyles.inter.copyWith(
                                          color: appPrimaryColor, fontSize: 20),
                                    )
                                  ],
                                ),
                                const Divider(
                                  color: dividerColor,
                                ),
                                10.heightXBox,
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        AutoSizeText('Price',
                                            style: TextStyles.inter.copyWith(
                                                color: purple[1],
                                                fontSize: 15)),
                                        AutoSizeText('63.75 SR',
                                            style: TextStyles.inter.copyWith(
                                                color: purple[4],
                                                fontSize: 15)),
                                      ],
                                    )),
                                10.heightXBox,
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        AutoSizeText('TAX',
                                            style: TextStyles.inter.copyWith(
                                                color: purple[1],
                                                fontSize: 15)),
                                        AutoSizeText('11 SR',
                                            style: TextStyles.inter.copyWith(
                                                color: purple[4],
                                                fontSize: 15)),
                                      ],
                                    )),
                                20.heightXBox,
                                Container(
                                  width: sw! * 0.9,
                                  padding: paddingAll(10),
                                  decoration: BoxDecoration(
                                    color: lightPurple,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AutoSizeText('Total',
                                          style: TextStyles.inter.copyWith(
                                              color: purple[1],
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                      AutoSizeText('75 SR',
                                          style: TextStyles.inter.copyWith(
                                              color: purple[4],
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                )
                              ])),

                      20.heightXBox,

                      Container(
                          width: sw! * 0.95,
                          padding: paddingAll(10),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(Assets.iconsApple,
                                    colorFilter: const ColorFilter.mode(
                                        Colors.white, BlendMode.srcIn)),
                                5.widthXBox,
                                AutoSizeText('Pay',
                                    style: TextStyles.inter.copyWith(
                                      color: Colors.white,
                                      fontSize: 18,
                                    )),
                              ])),
                      20.heightXBox,

                      ///
                    ]))));
  }
}
