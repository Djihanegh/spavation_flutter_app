import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';

import '../../../../../app/theme.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/constant.dart';
import '../../../../../core/utils/endpoint.dart';
import '../../../../../core/utils/format_date.dart';
import '../../../../../core/utils/navigation.dart';
import '../../../../../core/utils/size_config.dart';
import '../../../../../core/utils/typedef.dart';
import '../../../../../core/widgets/app_snack_bar.dart';
import '../../../../../core/widgets/custom_back_button.dart';
import '../../../../../generated/assets.dart';
import '../../../../../localization.dart';
import '../../../../reservation/presentation/screens/payment_screen.dart';
import '../../../data/models/product_model.dart';
import '../../bloc/product_bloc.dart';
import 'product_item.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({
    super.key,
    //    required this.data,
    //  required this.selectedProducts,
    required this.salonId,
    required this.isForFemale,
    required this.isForMale,
    required this.distance,
    required this.name,
    required this.description,
    required this.image,
    required this.taxRate,
    required this.taxNumber,
    required this.closeTime,
    //   required this.reservations
  });

  // final List<ProductModel> data;
  // final List<ProductModel> selectedProducts;
  final String salonId;
  final bool isForFemale;
  final bool isForMale;
  final String distance;
  final String name;
  final String description;
  final String image;
  final String taxRate;
  final String taxNumber;
  final String closeTime;

  // final DataMap reservations;

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  double totalPrice = 0.0;
  bool isNotEmpty = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {},
        builder: (context, state) {
          DataMap reservations = state.reservations ?? {};
          //if (state.data != null) {
          ProductModel product = ProductModel.empty();
          if (state.data!.isNotEmpty) {
            product = state.data![0];
          }
          totalPrice = 0.0;
          state.selectedProducts?.forEach((element) {
            if (element.salonId == widget.salonId) {
              isNotEmpty = true;
              totalPrice = totalPrice + int.parse(element.price);
            } else {
              isNotEmpty = false;
            }
          });
          if (state.selectedProducts != null) {
            if (state.selectedProducts!.isEmpty) {
              isNotEmpty = false;
            }
          } else {
            isNotEmpty = false;
          }

          return Column(
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
                                product.discount != ''
                                    ? int.parse(product.discount) > 0
                                        ? Positioned(
                                            right: sw! * 0.03,
                                            top: 0,
                                            child: Column(
                                              children: [
                                                SvgPicture.asset(Assets
                                                    .iconsIonicIosBookmark),
                                                AutoSizeText(
                                                  '${product.discount}%',
                                                  style: TextStyles.montserrat
                                                      .copyWith(
                                                          color: red[0],
                                                          fontWeight:
                                                              FontWeight.w300),
                                                )
                                              ],
                                            ))
                                        : emptyWidget()
                                    : emptyWidget(),
                                Positioned(
                                    right: l10n.localeName == 'en'
                                        ? sw! * 0.2
                                        : sw! * 0.28,
                                    top: sh! * 0.01,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AutoSizeText(
                                          widget.name,
                                          style: TextStyles.inter.copyWith(
                                              color: appPrimaryColor,
                                              fontSize: 25,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                            height: sh! * 0.2,
                                            width: sw! * 0.4,
                                            child: AutoSizeText(
                                              widget.description,
                                              style: TextStyles.montserrat
                                                  .copyWith(
                                                      color: appPrimaryColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w300),
                                            ))
                                      ],
                                    )),
                                Positioned(
                                    left: l10n.localeName == 'en'
                                        ? sw! * 0.14
                                        : sw! * 0.14,
                                    top: sh! * 0.09,
                                    child: SizedBox(
                                        width: sw! * 0.65,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const AutoSizeText(''),
                                                  if (widget.isForFemale)
                                                    Image.asset(
                                                        Assets
                                                            .iconsAwesomeFemale,
                                                        color: appPrimaryColor),
                                                  const AutoSizeText('')
                                                ]),
                                            //  5.widthXBox,
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const AutoSizeText(''),
                                                  if (widget.isForMale)
                                                    Image.asset(
                                                        Assets.iconsAwesomeMale,
                                                        height: 20,
                                                        color: appPrimaryColor),
                                                  const AutoSizeText('')
                                                ]),
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const AutoSizeText(''),
                                                  SvgPicture.asset(
                                                      Assets.iconsHomeSvg),
                                                  const AutoSizeText(''),
                                                ]),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.location_on,
                                                  size: 15,
                                                  color: appPrimaryColor,
                                                ),
                                                Text(
                                                  widget.distance.length > 6
                                                      ? '${'${widget.distance.split('.')[0]}.${widget.distance.split('.')[1].substring(0, 2)}'} ${l10n.km}'
                                                      : '${widget.distance} ${l10n.km}',
                                                  style: TextStyles.inter
                                                      .copyWith(
                                                          fontSize: 10,
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
                                                SvgPicture.asset(
                                                    Assets.iconsClockSvg),
                                                Text(
                                                  '${l10n.closeAt} ${getHourMnSec(widget.closeTime) != '' ? getHourMnSec(widget.closeTime) : ''}',
                                                  style: TextStyles.inter
                                                      .copyWith(
                                                          fontSize: 10,
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
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(5),
                                      topLeft: Radius.circular(5))),
                              child: Image.network(
                                Endpoints.storageUrl + widget.image,
                                fit: BoxFit.cover,
                              ),
                            ))
                      ],
                    )),
                Container(
                    height: sh! * 0.45,
                    width: sw! * 0.9,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Stack(
                      children: [
                        Positioned(
                            bottom: sh! * 0.09,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                    height: sh! * 0.36,
                                    width: sw!,
                                    child: ListView.builder(
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        itemCount: state.data?.length ?? 0,
                                        itemBuilder: (context, index) {
                                          final item = state.data?[index];
                                          if (widget.salonId == item?.salonId) {
                                            return ProductItem(
                                              product: state.data![index],
                                            );
                                          }

                                          return emptyWidget();
                                        })),
                              ],
                            )),
                        Positioned(
                            bottom: 0,
                            child: GestureDetector(
                                onTap: () {
                                  if (reservations[widget.salonId] != null) {
                                    if (reservations[widget.salonId]
                                        .isNotEmpty) {
                                      if (reservations[widget.salonId][0]
                                              ['date'] ==
                                          null) {
                                        setState(() {
                                          openSnackBar(
                                              context,
                                              l10n.pleaseSelectDateReservation,
                                              AnimatedSnackBarType.warning);
                                        });

                                        return;
                                      }

                                      if (reservations[widget.salonId][0]
                                              ['time'] ==
                                          null) {
                                        setState(() {
                                          openSnackBar(
                                              context,
                                              l10n.pleaseSelectReservationTime,
                                              AnimatedSnackBarType.warning);
                                        });

                                        return;
                                      }
                                    }
                                  }

                                  if (isNotEmpty) {
                                    navigateToPage(
                                        PaymentScreen(
                                          salonId: widget.salonId,
                                          taxNumber: widget.taxNumber,
                                          taxRate: widget.taxRate,
                                        ),
                                        context);
                                  }
                                },
                                child: Container(
                                  height: 40,
                                  width: sw! * 0.9,
                                  decoration: BoxDecoration(
                                      color: !isNotEmpty ? grey[0] : green[0],
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20))),
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          AutoSizeText(
                                            l10n.servicesDetails,
                                            style: TextStyles.inter.copyWith(
                                                color: Colors.white,
                                                fontSize: 15),
                                          ),
                                          AutoSizeText(
                                              '$totalPrice ${l10n.riyal}',
                                              style: TextStyles.inter.copyWith(
                                                  color: Colors.white,
                                                  fontSize: 15))
                                        ],
                                      )),
                                )))
                      ],
                    )),
                Container(
                  height: sh! * 0.02,
                )
              ]);
        });
  }
}
