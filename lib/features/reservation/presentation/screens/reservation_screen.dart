import 'package:dotted_line/dotted_line.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:spavation/app/theme.dart';
import 'package:spavation/core/cache/cache.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/core/utils/app_styles.dart';
import 'package:spavation/core/utils/constant.dart';
import 'package:spavation/core/utils/size_config.dart';
import 'package:spavation/core/widgets/loading_widget.dart';
import '../../../../core/utils/typedef.dart';
import '../../../../core/widgets/error_widget.dart';
import '../bloc/reservation_bloc.dart';
import '../widgets/reservation_item.dart';
import '../widgets/status_button.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  late ReservationBloc _reservationBloc;
  String token = '';
  bool showDetailsList = false;
  int index = -1;

  @override
  void initState() {
    token = Prefs.getString(Prefs.TOKEN) ?? '';
    _reservationBloc = BlocProvider.of(context);
    _reservationBloc.add(GetReservationsEvent(token));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenSizeInit(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: BlocConsumer<ReservationBloc, ReservationState>(
                listener: (context, state) {},
                listenWhen: (prev, curr) => prev.status != curr.status,
                builder: (context, state) {
                  Widget? child;
                  Widget? subChild;

                  child = body(subChild);

                  if (state.status == FormzSubmissionStatus.failure) {
                    subChild = CustomErrorWidget(
                      onRefresh: () => _refresh(),
                      errorMessage: state.errorMessage,
                    );
                  }

                  if (state.status == FormzSubmissionStatus.initial ||
                      state.status == FormzSubmissionStatus.inProgress) {
                    subChild = const LoadingWidget();
                  }

                  if (state.reservations != null) {
                    if (state.reservations!.isNotEmpty) {
                      subChild = ListView.builder(
                          shrinkWrap: true,
                          //  physics: const ClampingScrollPhysics(),
                          itemCount: state.reservations?.length,
                          itemBuilder: (context, indexA) {
                            double totalPrice = 0.0;
                            double totalTax = 0.0;
                            double discount = 0.0;

                            totalPrice =
                                double.parse(state.reservations![indexA].total);

                            //     discount =
                            //       double.parse(state.reservations![indexA].products[0);

                            totalTax = double.parse(
                                state.reservations![indexA].totalTax);

                            return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    showDetailsList = !showDetailsList;
                                    index = indexA;
                                  });
                                },
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: AutoSizeText(
                                        '${l10n.reservation} ${l10n.id}:',
                                        style: TextStyles.inter.copyWith(
                                            color: whiteWithOpacity,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16),
                                      ),
                                      subtitle: Row(children: [
                                        AutoSizeText(
                                          "${state.reservations![indexA].id}",
                                          style: TextStyles.inter.copyWith(
                                              color: whiteWithOpacity,
                                              fontSize: 14),
                                        ),
                                        10.widthXBox,
                                        StatusButton(
                                          status: state
                                              .reservations![indexA].status,
                                        )
                                      ]),
                                      trailing: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 30,
                                          child: Icon(
                                            showDetailsList && index == indexA
                                                ? Icons.arrow_drop_up
                                                : Icons.arrow_drop_down,
                                            color: Colors.black,
                                          )),
                                    ),
                                    showDetailsList && index == indexA
                                        ? SingleChildScrollView(
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const ClampingScrollPhysics(),
                                                itemCount: state
                                                    .reservations?[indexA]
                                                    .products
                                                    .length,
                                                itemBuilder: (context, indexB) {
                                                  DataMap reservation = state
                                                      .reservations?[indexA]
                                                      .products[indexB];

                                                  return ReservationItem(
                                                    reservation: reservation,
                                                  );
                                                }))
                                        : emptyWidget(),
                                    showDetailsList && index == indexA
                                        ? const DottedLine(
                                            dashLength: 5,
                                            dashGapLength: 5,
                                            lineThickness: 1,
                                            dashColor: lightPurple,
                                          )
                                        : emptyWidget(),
                                    showDetailsList && index == indexA
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10,
                                                left: 20,
                                                right: 20,
                                                bottom: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AutoSizeText(
                                                  l10n.tax,
                                                  style: TextStyles.inter
                                                      .copyWith(
                                                          color:
                                                              whiteWithOpacity,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 16),
                                                ),
                                                AutoSizeText(
                                                  "$totalTax ${l10n.sr}",
                                                  style: TextStyles.inter
                                                      .copyWith(
                                                          color:
                                                              whiteWithOpacity,
                                                          fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          )
                                        : emptyWidget(),
                                    showDetailsList && index == indexA
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20,
                                                right: 20,
                                                bottom: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AutoSizeText(
                                                  l10n.discount,
                                                  style: TextStyles.inter
                                                      .copyWith(
                                                          color:
                                                              whiteWithOpacity,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 16),
                                                ),
                                                AutoSizeText(
                                                  "$discount ${l10n.sr}",
                                                  style: TextStyles.inter
                                                      .copyWith(
                                                          color:
                                                              whiteWithOpacity,
                                                          fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          )
                                        : emptyWidget(),
                                    showDetailsList && index == indexA
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20,
                                                right: 20,
                                                bottom: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AutoSizeText(
                                                  l10n.total,
                                                  style: TextStyles.inter
                                                      .copyWith(
                                                          color:
                                                              whiteWithOpacity,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 16),
                                                ),
                                                AutoSizeText(
                                                  "$totalPrice ${l10n.sr}",
                                                  style: TextStyles.inter
                                                      .copyWith(
                                                          color:
                                                              whiteWithOpacity,
                                                          fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          )
                                        : emptyWidget(),
                                  ],
                                ));
                          });
                    } else {
                      subChild = Center(
                          child: AutoSizeText(
                        l10n.noReservationFound,
                        style: TextStyles.inter.copyWith(color: Colors.white),
                      ));
                    }
                  }

                  if (subChild != null) {
                    child = body(subChild);
                  }

                  return child;
                })));
  }

  void _refresh() {
    _reservationBloc.add(GetReservationsEvent(token));
  }

  Widget body(Widget? subChild) {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Stack(children: [
          Container(
            height: sh!,
            color: Colors.white,
          ),
          Padding(
              padding: EdgeInsets.only(top: sh! * 0.1),
              child: Container(
                width: sw!,
                height: sh! * 0.2,
                decoration: BoxDecoration(
                  boxShadow: boxShadow2,
                  borderRadius: BorderRadius.circular(25),
                  color: appPrimaryColor.withOpacity(0.22),
                ),
                child: Padding(
                    padding: EdgeInsets.only(top: sh! * 0.05),
                    child: AutoSizeText(
                      l10n.reservations,
                      style: TextStyles.inter.copyWith(
                          fontSize: 40,
                          color: appPrimaryColor,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    )),
              )),
          Positioned(
              top: sh! * 0.25,
              bottom: 0,
              child: Container(
                  width: sw!,
                  height: sh!,
                  margin: const EdgeInsets.only(bottom: 80),
                  decoration: const BoxDecoration(
                    //  boxShadow: boxShadow2,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                    color: appPrimaryColor,
                  ),
                  child: subChild))
        ]));
  }
}
