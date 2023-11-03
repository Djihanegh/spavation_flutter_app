import 'dart:developer';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/core/utils/endpoint.dart';
import 'package:spavation/core/widgets/app_snack_bar.dart';
import 'package:spavation/core/widgets/loading_widget.dart';
import 'package:spavation/features/products/data/models/product_model.dart';

import '../../../../app/theme.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/constant.dart';
import '../../../../core/utils/format_date.dart';
import '../../../../core/utils/navigation.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../core/widgets/custom_back_button.dart';
import '../../../../generated/assets.dart';
import '../../../localization/domain/entities/language.dart';
import '../../../localization/presentation/bloc/language_bloc.dart';
import '../../../reservation/presentation/screens/payment_screen.dart';
import '../../../salons/presentation/screens/widgets/salon_error_widget.dart';
import '../bloc/product_bloc.dart';
import 'widgets/product_item.dart';
import 'widgets/product_loading_widget.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen(
      {super.key,
      required this.salonId,
      required this.isForMale,
      required this.isForFemale,
      required this.distance,
      required this.name,
      required this.description,
      required this.image,
      required this.taxRate,
      required this.taxNumber});

  final String salonId;
  final String isForMale;
  final String isForFemale;
  final String distance;
  final String name;
  final String description;
  final String image;
  final String taxRate;
  final String taxNumber;

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late ProductBloc _productBloc;
  int totalPrice = 0, totalTaxes = 0;

  @override
  void initState() {
    _productBloc = BlocProvider.of(context);
    _productBloc.add(GetProductsEvent(widget.salonId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    screenSizeInit(context);
    return Scaffold(
        backgroundColor: appPrimaryColor,
        body: SingleChildScrollView(
            child: BlocConsumer<LanguageBloc, LanguageState>(
                listener: (context, language) {},
                buildWhen: (prev, curr) =>
                    prev.selectedLanguage != curr.selectedLanguage,
                builder: (context, language) {
                  return BlocConsumer<ProductBloc, ProductState>(
                      listener: (context, state) {},
                      buildWhen: (prev, curr) =>
                          prev.reservations != curr.reservations ||
                          prev.selectedProducts != curr.selectedProducts ||
                          prev.status != curr.status,
                      builder: (context, state) {
                        Widget? child;
                        Widget? subChild;
                        totalPrice = 0;

                        child = body(subChild);

                        if (state.status == FormzSubmissionStatus.inProgress ||
                            state.status == FormzSubmissionStatus.initial) {
                          subChild = const ProductLoadingWidget();
                        }
                        if (state.status == FormzSubmissionStatus.failure) {
                          subChild = const SalonErrorWidget();
                        }

                        if (state.status == FormzSubmissionStatus.success &&
                            (state.data == [] || state.data == null)) {
                          subChild = Column(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                Text(l10n.noProductFound)
                              ]);

                          ;
                        }

                        if (state.status == FormzSubmissionStatus.success &&
                            state.data != null) {
                          if (state.data!.isNotEmpty) {
                            ProductModel product = ProductModel.empty();
                            if (state.data!.isNotEmpty) {
                              product = state.data![0];
                            }

                            state.selectedProducts?.forEach((element) {
                              totalPrice =
                                  totalPrice + int.parse(element.price);
                            });

                            subChild = Column(
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
                                          borderRadius:
                                              BorderRadius.circular(15)),
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
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                      right: sw! * 0.03,
                                                      top: 0,
                                                      child: Column(
                                                        children: [
                                                          SvgPicture.asset(Assets
                                                              .iconsIonicIosBookmark),
                                                          AutoSizeText(
                                                            '${product.discount}%',
                                                            style: TextStyles
                                                                .montserrat
                                                                .copyWith(
                                                                    color:
                                                                        red[0],
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300),
                                                          )
                                                        ],
                                                      )),
                                                  Positioned(
                                                      right: language
                                                                  .selectedLanguage
                                                                  .value ==
                                                              Language
                                                                  .english.value
                                                          ? sw! * 0.2
                                                          : sw! * 0.28,
                                                      top: sh! * 0.01,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          AutoSizeText(
                                                            widget.name,
                                                            style: TextStyles
                                                                .inter
                                                                .copyWith(
                                                                    color:
                                                                        appPrimaryColor,
                                                                    fontSize:
                                                                        25,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                          ),
                                                          SizedBox(
                                                              height: sh! * 0.2,
                                                              width: sw! * 0.4,
                                                              child:
                                                                  AutoSizeText(
                                                                widget
                                                                    .description,
                                                                style: TextStyles
                                                                    .montserrat
                                                                    .copyWith(
                                                                        color:
                                                                            appPrimaryColor,
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.w300),
                                                              ))
                                                        ],
                                                      )),
                                                  Positioned(
                                                      left: language
                                                                  .selectedLanguage
                                                                  .value ==
                                                              Language.values[0]
                                                                  .value
                                                          ? sw! * 0
                                                          : sw! * 0.14,
                                                      top: sh! * 0.09,
                                                      child: SizedBox(
                                                          width: sw! * 0.8,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    const AutoSizeText(
                                                                        ''),
                                                                    widget.isForFemale ==
                                                                            '1'
                                                                        ? Image.asset(
                                                                            Assets
                                                                                .iconsAwesomeFemale,
                                                                            color:
                                                                                appPrimaryColor)
                                                                        : emptyWidget(),
                                                                    const AutoSizeText(
                                                                        '')
                                                                  ]),
                                                              5.widthXBox,
                                                              Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    const AutoSizeText(
                                                                        ''),
                                                                    widget.isForMale ==
                                                                            '1'
                                                                        ? Image.asset(
                                                                            Assets
                                                                                .iconsAwesomeMale,
                                                                            height:
                                                                                20,
                                                                            color:
                                                                                appPrimaryColor)
                                                                        : emptyWidget(),
                                                                    const AutoSizeText(
                                                                        '')
                                                                  ]),
                                                              Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    const AutoSizeText(
                                                                        ''),
                                                                    SvgPicture.asset(
                                                                        Assets
                                                                            .iconsHomeSvg),
                                                                    const AutoSizeText(
                                                                        ''),
                                                                  ]),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  const Icon(
                                                                    Icons
                                                                        .location_on,
                                                                    size: 15,
                                                                    color:
                                                                        appPrimaryColor,
                                                                  ),
                                                                  Text(
                                                                    widget.distance.length >
                                                                            6
                                                                        ? '${'${widget.distance.split('.')[0]}.${widget.distance.split('.')[1].substring(0, 2)}'} ${l10n.km}'
                                                                        : '${widget.distance} ${l10n.km}',
                                                                    style: TextStyles
                                                                        .inter
                                                                        .copyWith(
                                                                            fontSize:
                                                                                10,
                                                                            color:
                                                                                appPrimaryColor),
                                                                  ),
                                                                ],
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  SvgPicture.asset(
                                                                      Assets
                                                                          .iconsClockSvg),
                                                                  Text(
                                                                    '${l10n.closeAt} ${getHourMnSec(product.timeTo).substring(1, 2)}${getHourMnSec(product.timeTo).substring(6, 8)}',
                                                                    // Close At 11PM
                                                                    style: TextStyles
                                                                        .inter
                                                                        .copyWith(
                                                                            fontSize:
                                                                                10,
                                                                            color:
                                                                                appPrimaryColor),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ))),
                                                  Positioned(
                                                      left: 0,
                                                      top: sh! * 0.17,
                                                      //sh! * 0.205,
                                                      child: Container(
                                                        color: dividerColor,
                                                        width: sw!,
                                                        height: 1,
                                                      ))
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
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    5),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    5),
                                                            topLeft:
                                                                Radius.circular(
                                                                    5))),
                                                child: Image.network(
                                                    Endpoints.storageUrl +
                                                        widget.image),
                                              ))
                                        ],
                                      )),
                                  Container(
                                      height: sh! * 0.45,
                                      width: sw! * 0.9,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                              bottom: sh! * 0.09,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                      height: sh! * 0.36,
                                                      width: sw!,
                                                      child: ListView.builder(
                                                          physics:
                                                              const AlwaysScrollableScrollPhysics(),
                                                          itemCount: state
                                                              .data?.length,
                                                          itemBuilder: (context,
                                                                  index) =>
                                                              ProductItem(
                                                                product:
                                                                    state.data![
                                                                        index],
                                                              ))),
                                                ],
                                              )),
                                          Positioned(
                                              bottom: 0,
                                              child: GestureDetector(
                                                  onTap: () {
                                                    if (state.selectedTime ==
                                                            null ||
                                                        state.selectedTime!
                                                            .isEmpty) {
                                                      openSnackBar(
                                                          context,
                                                          l10n
                                                              .pleaseSelectReservationTime,
                                                          AnimatedSnackBarType
                                                              .warning);
                                                      return;
                                                    }

                                                    if (state.selectedDate ==
                                                        null) {
                                                      openSnackBar(
                                                          context,
                                                          l10n
                                                              .pleaseSelectDateReservation,
                                                          AnimatedSnackBarType
                                                              .warning);
                                                      return;
                                                    }

                                                    navigateToPage(
                                                        PaymentScreen(
                                                          salonId:
                                                              widget.salonId,
                                                          taxNumber:
                                                              widget.taxNumber,
                                                          taxRate:
                                                              widget.taxRate,
                                                        ),
                                                        context);
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width: sw! * 0.9,
                                                    decoration: BoxDecoration(
                                                        color: state.selectedProducts !=
                                                                null
                                                            ? state.selectedProducts!
                                                                    .isNotEmpty
                                                                ? green[0]
                                                                : grey[0]
                                                            : grey[0],
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                topRight: Radius
                                                                    .circular(
                                                                        20))),
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10,
                                                                right: 10),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            AutoSizeText(
                                                              l10n.servicesDetails,
                                                              style: TextStyles
                                                                  .inter
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          15),
                                                            ),
                                                            AutoSizeText(
                                                                '$totalPrice ${l10n.riyal}',
                                                                style: TextStyles
                                                                    .inter
                                                                    .copyWith(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            15))
                                                          ],
                                                        )),
                                                  )))
                                        ],
                                      )),
                                  Container(
                                    height: sh! * 0.02,
                                  )
                                ]);
                          } else {
                            subChild = Column(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                  Text(l10n.noProductFound)
                                ]);
                          }
                        }

                        if (subChild != null) {
                          child = body(subChild);
                        }

                        return child;
                      });
                })));
  }

  Widget body(Widget? subChild) {
    return Center(
        child: Stack(alignment: Alignment.center, children: [
      Padding(
          padding: EdgeInsets.only(
              top: subChild is LoadingWidget ? sh! * 0.2 : sh! * 0.15),
          child: subChild ?? emptyWidget()),
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
    ]));
  }
}
