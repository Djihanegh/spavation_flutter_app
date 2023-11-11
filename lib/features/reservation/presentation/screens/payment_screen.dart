import 'dart:core';
import 'dart:developer';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:spavation/core/enum/enum.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/core/utils/constant.dart';
import 'package:spavation/core/utils/navigation.dart';
import 'package:spavation/core/widgets/app_button.dart';
import 'package:spavation/core/widgets/app_snack_bar.dart';
import 'package:spavation/features/home/presentation/screens/home/home_screen.dart';
import 'package:spavation/features/reservation/presentation/bloc/reservation_bloc.dart';
import 'package:spavation/features/reservation/presentation/widgets/disocunt_code_widget.dart';
import 'package:spavation/features/reservation/presentation/widgets/service_details_item.dart';
import 'package:spavation/generated/assets.dart';
import '../../../../app/theme.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../core/utils/typedef.dart';
import '../../../../core/widgets/custom_back_button.dart';
import '../../../home/presentation/screens/filter/widgets/filter_choice_box.dart';
import '../../../products/data/models/product_model.dart';
import '../../../products/presentation/bloc/product_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen(
      {super.key,
      required this.salonId,
      required this.taxRate,
      required this.taxNumber});

  final String salonId;
  final String taxRate;
  final String taxNumber;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String paymentMethod = 'apple';
  List<int> ids = [];

  List<ProductModel> selectedProducts = [];
  List<DataMap> products = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

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
                    builder: (context, productState) {
                      return BlocConsumer<ReservationBloc, ReservationState>(
                          listener: (context, state) {
                            if (state.action == RequestType.addReservation) {
                              if (state.status ==
                                  FormzSubmissionStatus.success) {
                                context
                                    .read<ProductBloc>()
                                    .add(const RemoveReservation());
                                openSnackBar(context, state.successMessage,
                                    AnimatedSnackBarType.success);
                                navigateAndRemoveUntil(
                                    const HomeScreen(), context, false);
                              } else if (state.status ==
                                  FormzSubmissionStatus.failure) {
                                openSnackBar(context, state.errorMessage,
                                    AnimatedSnackBarType.error);
                              }
                            }
                          },
                          listenWhen: (prev, curr) =>
                              prev.status != curr.status,
                          //   buildWhen: (prev, curr) => prev.status != curr.status,
                          builder: (context, reservationState) {
                            double totalPrice = 0.0;
                            String totalTaxes = '0';
                            log(reservationState.discount);
                            double discount = 0.0;
                            try {
                              discount =
                                  double.parse(reservationState.discount);
                            } catch (e) {
                              log(e.toString());
                            }

                            Map<String, List<DataMap>>? reservations =
                                productState.reservations;
                            for (ProductModel e
                                in productState.selectedProducts ?? []) {
                              if (widget.salonId == e.salonId) {
                                totalPrice = totalPrice + double.parse(e.price);

                                if (reservations != null) {
                                  if (reservations.containsKey(e.salonId)) {
                                    List<DataMap>? data =
                                        reservations[e.salonId];
                                    if (data != null) {
                                      int index = data.indexWhere(
                                          (element) => element['id'] == e.id);

                                      if (index != -1) {
                                        e.setTime(data[index]['time']);
                                        if (data[index]['date'] != null) {
                                          e.setDate(data[index]['date']);
                                        }

                                        if (!selectedProducts.contains(e)) {
                                          selectedProducts.add(e);

                                          List<String> times =
                                              e.time.split('-');
                                          List<String> startTime =
                                              times[0].split(' ');

                                          List<String> endTime =
                                              times[1].split(' ');

                                          products.add({
                                            'id': e.id,
                                            'name': e.name,
                                            'date':
                                                "${e.date.day}-${e.date.month}-${e.date.year}",
                                            'time': e.time,
                                            //  "${startTime[0].replaceAll(" ", '')} - ${endTime[1].replaceAll(" ", '')}",
                                            'image': e.image,
                                            'description': e.description,
                                            'price': e.price,
                                            'status': e.status
                                          });
                                        }
                                      }
                                    }
                                  }
                                }
                              }
                            }
                            log(products.toString());

                            totalTaxes = ((totalPrice / 1.15) - totalPrice)
                                .abs()
                                .toStringAsFixed(2);

                            return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      AutoSizeText(
                                        '',
                                        style: TextStyles.inter.copyWith(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                      AutoSizeText(
                                        l10n.requestReview,
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
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                                Assets.iconsMaterialDetails),
                                            10.widthXBox,
                                            AutoSizeText(
                                              l10n.servicesDetails,
                                              style: TextStyles.inter.copyWith(
                                                  color: appPrimaryColor,
                                                  fontSize: 20),
                                            )
                                          ],
                                        ),
                                        for (ProductModel product
                                            in productState.selectedProducts ??
                                                [])
                                          widget.salonId == product.salonId
                                              ? ServiceDetailsItem(
                                                  productId: "${product.id}",
                                                  salonId: product.salonId,
                                                  productName: product.name,
                                                  productPrice: product.price,
                                                  selectedDate: productState
                                                      .selectedDate!,
                                                  selectedTime: productState
                                                          .selectedTime ??
                                                      '')
                                              : emptyWidget()
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
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            10.heightXBox,
                                            Row(children: [
                                              SvgPicture.asset(
                                                  Assets.iconsMaterialPayment,
                                                  colorFilter: ColorFilter.mode(
                                                      purple[1],
                                                      BlendMode.srcIn)),
                                              10.widthXBox,
                                              AutoSizeText(
                                                l10n.paymentType,
                                                style: TextStyles.inter
                                                    .copyWith(
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
                                                  isSelected:
                                                      paymentMethod == 'apple'
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
                                                  l10n.payWithApple,
                                                  style: TextStyles.inter
                                                      .copyWith(
                                                          color: purple[1],
                                                          fontSize: 15),
                                                )
                                              ],
                                            ),
                                            5.heightXBox,
                                            Row(
                                              children: [
                                                FilterChoiceBox(
                                                  isSelected:
                                                      paymentMethod == 'card'
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
                                                  l10n.creditOrDebitCard,
                                                  style: TextStyles.inter
                                                      .copyWith(
                                                          color: purple[1],
                                                          fontSize: 15),
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
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
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
                                                SvgPicture.asset(Assets
                                                    .iconsAwesomeFileInvoice),
                                                10.widthXBox,
                                                AutoSizeText(
                                                  '${l10n.invoicementDetails}:',
                                                  style: TextStyles.inter
                                                      .copyWith(
                                                          color:
                                                              appPrimaryColor,
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    AutoSizeText(l10n.price,
                                                        style: TextStyles.inter
                                                            .copyWith(
                                                                color:
                                                                    purple[1],
                                                                fontSize: 15)),
                                                    AutoSizeText(
                                                        totalPrice == 0.0
                                                            ? '0 ${l10n.sr}'
                                                            : '$totalPrice ${l10n.sr}',
                                                        style: TextStyles.inter
                                                            .copyWith(
                                                                color:
                                                                    purple[4],
                                                                fontSize: 15)),
                                                  ],
                                                )),
                                            10.heightXBox,
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20, right: 20),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    AutoSizeText(l10n.discount,
                                                        style: TextStyles.inter
                                                            .copyWith(
                                                                color:
                                                                    purple[1],
                                                                fontSize: 15)),
                                                    AutoSizeText(
                                                        '$discount ${l10n.sr}',
                                                        style: TextStyles.inter
                                                            .copyWith(
                                                                color:
                                                                    purple[4],
                                                                fontSize: 15)),
                                                  ],
                                                )),
                                            10.heightXBox,
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20, right: 20),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    AutoSizeText(l10n.tax,
                                                        style: TextStyles.inter
                                                            .copyWith(
                                                                color:
                                                                    purple[1],
                                                                fontSize: 15)),
                                                    AutoSizeText(
                                                        totalTaxes.isEmpty
                                                            ? '0 ${l10n.sr}'
                                                            : '$totalTaxes ${l10n.sr}',
                                                        style: TextStyles.inter
                                                            .copyWith(
                                                                color:
                                                                    purple[4],
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  AutoSizeText(l10n.total,
                                                      style: TextStyles.inter
                                                          .copyWith(
                                                              color: purple[1],
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                  AutoSizeText(
                                                      '${totalPrice - discount} ${l10n.sr}',
                                                      style: TextStyles.inter
                                                          .copyWith(
                                                              color: purple[4],
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                ],
                                              ),
                                            )
                                          ])),

                                  20.heightXBox,

                                  Container(
                                      width: sw! * 0.95,
                                      padding: paddingAll(0),
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: AppButton(
                                        isLoading: reservationState.status ==
                                                FormzSubmissionStatus.inProgress
                                            ? true
                                            : false,
                                        borderColor: Colors.black,
                                        title: l10n.pay,
                                        color: Colors.black,
                                        textColor: Colors.white,
                                        onPressed: () {
                                          setState(() {
                                            log(widget.salonId.toString());
                                            context
                                                .read<ReservationBloc>()
                                                .add(AddReservationEvent({
                                                  'products': products,
                                                  'status': 'pending',
                                                  'payment_method':
                                                      paymentMethod,
                                                  'salon_id': widget.salonId,
                                                  'total_tax': totalTaxes,
                                                  'total':
                                                      '${totalPrice - discount}'
                                                }));
                                          });
                                        },
                                      )),

                                  20.heightXBox,

                                  ///
                                ]);
                          });
                    }))));
  }
}
