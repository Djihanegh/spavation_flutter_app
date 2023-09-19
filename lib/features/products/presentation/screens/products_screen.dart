import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/core/utils/endpoint.dart';
import 'package:spavation/features/products/data/models/product_model.dart';

import '../../../../app/theme.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/constant.dart';
import '../../../../core/utils/navigation.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../core/widgets/custom_back_button.dart';
import '../../../../generated/assets.dart';
import '../../../home/presentation/screens/pay/payment_screen.dart';
import '../../../salons/presentation/screens/widgets/salon_error_widget.dart';
import '../../../salons/presentation/screens/widgets/salon_loadig_widget.dart';
import '../bloc/product_bloc.dart';
import 'widgets/service_item.dart';
import 'widgets/showDialog.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen(
      {super.key,
      required this.salonId,
      required this.isForMale,
      required this.isForFemale,
      required this.distance,
      required this.name,
      required this.description,
      required this.image});

  final String salonId;
  final String isForMale;
  final String isForFemale;
  final String distance;
  final String name;
  final String description;
  final String image;

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late ProductBloc _productBloc;

  @override
  void initState() {
    _productBloc = BlocProvider.of(context);
    _productBloc.add(GetProductsEvent(widget.salonId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenSizeInit(context);
    return Scaffold(
        backgroundColor: appPrimaryColor,
        body: SingleChildScrollView(
            child: BlocConsumer<ProductBloc, ProductState>(
                listener: (context, state) {},
                listenWhen: (prev, curr) => prev.status != curr.status,
                buildWhen: (prev, curr) => prev.status != curr.status,
                builder: (context, state) {
                  Widget? child;

                  log(state.data.toString());

                  if (state.status == FormzSubmissionStatus.inProgress) {
                    child = const SalonShimmer();
                  }
                  if (state.status == FormzSubmissionStatus.failure) {
                    child = const SalonErrorWidget();
                  }

                  if (state.status == FormzSubmissionStatus.initial) {
                    child = const SalonShimmer();
                  }

                  if (state.status == FormzSubmissionStatus.success &&
                      (state.data == [] || state.data == null)) {
                    child = const Text('No salon found ');
                  }

                  if (state.status == FormzSubmissionStatus.success &&
                      state.data != [] &&
                      state.data != null) {
                    ProductModel product = state.data![0];
                    child = Center(
                        child: Stack(alignment: Alignment.center, children: [
                      Padding(
                          padding: EdgeInsets.only(top: sh! * 0.15),
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
                                                    BorderRadius.circular(15)),
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
                                                                  color: red[0],
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300),
                                                        )
                                                      ],
                                                    )),
                                                Positioned(
                                                    right: sw! * 0.2,
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
                                                          style: TextStyles.inter
                                                              .copyWith(
                                                                  color:
                                                                      appPrimaryColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        ),
                                                        SizedBox(
                                                            height: sh! * 0.2,
                                                            width: sw! * 0.4,
                                                            child: AutoSizeText(
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
                                                                          FontWeight
                                                                              .w300),
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
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            widget.isForFemale ==
                                                                    '1'
                                                                ? Image.asset(
                                                                    Assets
                                                                        .iconsAwesomeFemale,
                                                                    color:
                                                                        appPrimaryColor)
                                                                : emptyWidget(),
                                                            5.widthXBox,
                                                            widget.isForMale ==
                                                                    '1'
                                                                ? Image.asset(
                                                                    Assets
                                                                        .iconsAwesomeMale,
                                                                    color:
                                                                        appPrimaryColor)
                                                                : emptyWidget(),
                                                            const Icon(
                                                              Icons.home_filled,
                                                              color:
                                                                  appPrimaryColor,
                                                            ),
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
                                                                  color:
                                                                      appPrimaryColor,
                                                                ),
                                                                AutoSizeText(
                                                                  widget.distance
                                                                              .length >
                                                                          6
                                                                      ? '${'${widget.distance.split('.')[0]}.${widget.distance.split('.')[1].substring(0, 2)}'} km'
                                                                      : '${widget.distance} k.m',
                                                                  style: TextStyles
                                                                      .inter
                                                                      .copyWith(
                                                                          fontSize:
                                                                              7,
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
                                                                Image.asset(
                                                                  Assets
                                                                      .iconsClock,
                                                                  height: 20,
                                                                  width: 20,
                                                                ),
                                                                AutoSizeText(
                                                                  'Close At ${DateFormat("hh:mm a").format(product.timeTo)}',
                                                                  // Close At 11PM
                                                                  style: TextStyles
                                                                      .inter
                                                                      .copyWith(
                                                                          fontSize:
                                                                              6,
                                                                          color:
                                                                              appPrimaryColor),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ))),
                                                Positioned(
                                                    left: 0,
                                                    top: sh! * 0.205,
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
                                            bottom: sh! * 0.05,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                10.heightXBox,
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: sw! * 0.07,
                                                        right: 10),
                                                    child: RichText(
                                                      text: TextSpan(
                                                        // text: 'Hello ',
                                                        style:
                                                            DefaultTextStyle.of(
                                                                    context)
                                                                .style,
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                              text: 'All',
                                                              style: TextStyles
                                                                  .inter
                                                                  .copyWith(
                                                                      color: red[
                                                                          2],
                                                                      fontSize:
                                                                          15)),
                                                          TextSpan(
                                                              text:
                                                                  ' Hair Nails Massage Hair Nails Massage ',
                                                              style: TextStyles
                                                                  .inter
                                                                  .copyWith(
                                                                      color:
                                                                          appFilterCoLOR,
                                                                      fontSize:
                                                                          15)),
                                                        ],
                                                      ),
                                                    )),
                                                SizedBox(
                                                    height: sh! * 0.36,
                                                    width: sw!,
                                                    child: ListView.builder(
                                                        physics:
                                                            const AlwaysScrollableScrollPhysics(),
                                                        itemCount: 9,
                                                        itemBuilder: (context,
                                                                index) =>
                                                            GestureDetector(
                                                                onTap: () =>
                                                                    showDateTimeDialog(
                                                                        context:
                                                                            context),
                                                                child:
                                                                    const ServiceItem()))),
                                              ],
                                            )),
                                        Positioned(
                                            bottom: 0,
                                            child: GestureDetector(
                                                onTap: () => navigateToPage(
                                                    const PaymentScreen(),
                                                    context),
                                                child: Container(
                                                  height: 40,
                                                  width: sw! * 0.9,
                                                  decoration: BoxDecoration(
                                                      color: grey[0],
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .only(
                                                              topLeft: Radius
                                                                  .circular(20),
                                                              topRight: Radius
                                                                  .circular(
                                                                      20))),
                                                  child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
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
                                                            'Services details',
                                                            style: TextStyles
                                                                .inter
                                                                .copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        15),
                                                          ),
                                                          AutoSizeText('Riyal',
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
                    ]));
                  }

                  return child!;
                })));
  }
}
