import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/core/widgets/app_button.dart';
import 'package:spavation/features/reservation/presentation/bloc/reservation_bloc.dart';
import 'package:spavation/features/reservation/presentation/widgets/disocunt_code_widget.dart';
import 'package:spavation/features/reservation/presentation/widgets/service_details_item.dart';
import 'package:spavation/features/settings/presentation/screens/update_user/widgets/custom_text_field.dart';
import 'package:spavation/generated/assets.dart';

import '../../../../app/theme.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../core/widgets/custom_back_button.dart';
import '../../../home/presentation/screens/filter/widgets/filter_choice_box.dart';
import '../../../products/data/models/product_model.dart';
import '../../../products/presentation/bloc/product_bloc.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key, required this.salonId});

  final String salonId;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String paymentMethod = 'apple';

  @override
  Widget build(BuildContext context) {
    screenSizeInit(context);
    return Scaffold(
        backgroundColor: appPrimaryColor,
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(top: sh! * 0.15),
                child: BlocConsumer<ProductBloc, ProductState>(
                    listener: (context, state) {},
                    listenWhen: (prev, curr) => prev.status != curr.status,
                    buildWhen: (prev, curr) => prev.status != curr.status,
                    builder: (context, state) {
                      String totalPrice = '', totalTaxes = '10';
                      for (ProductModel e in state.selectedProducts ?? []) {
                        totalPrice = totalPrice + e.price;
                        totalTaxes = totalTaxes;
                      }
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                AutoSizeText(
                                  '',
                                  style: TextStyles.inter.copyWith(
                                      color: Colors.white, fontSize: 15),
                                ),
                                AutoSizeText(
                                  'Request Review',
                                  style: TextStyles.inter.copyWith(
                                      color: Colors.white, fontSize: 20),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                          Assets.iconsMaterialDetails),
                                      10.widthXBox,
                                      AutoSizeText(
                                        'Services Details',
                                        style: TextStyles.inter.copyWith(
                                            color: appPrimaryColor,
                                            fontSize: 20),
                                      )
                                    ],
                                  ),
                                  for (ProductModel product
                                      in state.selectedProducts ?? [])
                                    ServiceDetailsItem(
                                        productId: "${product.id}",
                                        salonId: product.salonId,
                                        productName: product.name,
                                        productPrice: product.price,
                                        selectedDate: state.selectedDate!,
                                        selectedTime: state.selectedTime ?? '')
                                ],
                              ),
                            ),

                            Container(
                                width: sw! * 0.95,
                                margin: paddingAll(10),
                                padding: paddingAll(10),
                                decoration: BoxDecoration(
                                    boxShadow: boxShadow,
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      10.heightXBox,
                                      Row(children: [
                                        SvgPicture.asset(
                                            Assets.iconsMaterialPayment,
                                            colorFilter: ColorFilter.mode(
                                                purple[1], BlendMode.srcIn)),
                                        10.widthXBox,
                                        AutoSizeText(
                                          'Payment Type',
                                          style: TextStyles.inter.copyWith(
                                              color: appPrimaryColor,
                                              fontSize: 20),
                                        )
                                      ]),
                                      const Divider(
                                        color: dividerColor,
                                      ),
                                      Row(
                                        children: [
                                          FilterChoiceBox(
                                            isSelected: paymentMethod == 'apple'
                                                ? true
                                                : false,
                                            title: '',
                                            onChanged: () {
                                              setState(() {
                                                paymentMethod = 'apple';
                                              });
                                            },
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
                                          FilterChoiceBox(
                                            isSelected: paymentMethod == 'card'
                                                ? true
                                                : false,
                                            title: '',
                                            onChanged: () {
                                              setState(() {
                                                paymentMethod = 'card';
                                              });
                                            },
                                          ),
                                          5.widthXBox,
                                          SvgPicture.asset(
                                              Assets.iconsVisaCard),
                                          5.widthXBox,
                                          AutoSizeText(
                                            'Credit or Debit Card',
                                            style: TextStyles.inter.copyWith(
                                                color: purple[1], fontSize: 15),
                                          )
                                        ],
                                      )
                                    ])),

                            DiscountCodeWidget(
                              salonId: widget.salonId,
                            ),

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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      10.heightXBox,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                              Assets.iconsAwesomeFileInvoice),
                                          10.widthXBox,
                                          AutoSizeText(
                                            'Invoicement Details:',
                                            style: TextStyles.inter.copyWith(
                                                color: appPrimaryColor,
                                                fontSize: 20),
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
                                                  style: TextStyles.inter
                                                      .copyWith(
                                                          color: purple[1],
                                                          fontSize: 15)),
                                              AutoSizeText(
                                                  totalPrice.isEmpty
                                                      ? '0 SR'
                                                      : '$totalPrice SR',
                                                  style: TextStyles.inter
                                                      .copyWith(
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
                                                  style: TextStyles.inter
                                                      .copyWith(
                                                          color: purple[1],
                                                          fontSize: 15)),
                                              AutoSizeText(
                                                  totalTaxes.isEmpty
                                                      ? '0 SR'
                                                      : '$totalTaxes SR',
                                                  style: TextStyles.inter
                                                      .copyWith(
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AutoSizeText('Total',
                                                style: TextStyles.inter
                                                    .copyWith(
                                                        color: purple[1],
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                            AutoSizeText(
                                                '${int.parse(totalTaxes) + int.parse(totalPrice)} SR',
                                                style: TextStyles.inter
                                                    .copyWith(
                                                        color: purple[4],
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold)),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                          ]);
                    }))));
  }
}
