import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../../../../core/widgets/navigate_next_btn.dart';
import '../../../../reservation/presentation/bloc/reservation_bloc.dart';
import '../../../../salons/presentation/screens/widgets/salon_error_widget.dart';
import 'widgets/bills_item.dart';
import '../../../../../app/theme.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/size_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BillsScreen extends StatefulWidget {
  const BillsScreen({super.key});

  @override
  State<BillsScreen> createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    screenSizeInit(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Stack(
              children: [
                Container(
                  height: sh!,
                  color: Colors.white,
                ),
                const NavigateNextButton(),
                GestureDetector(
                  child: Padding(
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
                              l10n.bills,
                              style: TextStyles.inter.copyWith(
                                  fontSize: 40,
                                  color: appPrimaryColor,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.center,
                            )),
                      )),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
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
                        child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20),
                            child: BlocConsumer<ReservationBloc,
                                    ReservationState>(
                                listener: (context, state) {},
                                listenWhen: (prev, curr) =>
                                    prev.status != curr.status,
                                builder: (context, state) {
                                  Widget? child;
                                  Widget? subChild;

                                  // child = subChild;

                                  if (state.status ==
                                      FormzSubmissionStatus.failure) {
                                    subChild = const SalonErrorWidget();
                                  }

                                  if (state.status ==
                                          FormzSubmissionStatus.initial ||
                                      state.status ==
                                          FormzSubmissionStatus.inProgress) {
                                    subChild = const LoadingWidget();
                                  }

                                  if (state.reservations != null) {
                                    if (state.reservations!.isNotEmpty) {
                                      subChild = ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          itemCount: state.reservations?.length,
                                          itemBuilder: (context, indexA) {
                                            //  log(state.reservations![indexA].status);
                                            return BillsItem(
                                              reservationModel:
                                                  state.reservations![indexA],
                                            ); /* GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                  //  showDetailsList = !showDetailsList;
                                                //    index = indexA;
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
                                                        ? ListView.builder(
                                                        shrinkWrap: true,
                                                        physics:
                                                        const AlwaysScrollableScrollPhysics(),
                                                        itemCount: state
                                                            .reservations?[indexA]
                                                            .products
                                                            .length,
                                                        itemBuilder: (context, indexB) {
                                                          return ReservationItem(
                                                            reservation: state
                                                                .reservations?[indexA]
                                                                .products[indexB],
                                                          );
                                                        })
                                                        : emptyWidget(),
                                                  ],
                                                )); */
                                          });
                                    } else {
                                      subChild = Center(
                                          child: AutoSizeText(
                                        l10n.noReservationFound,
                                        style: TextStyles.inter
                                            .copyWith(color: Colors.white),
                                      ));
                                    }
                                  }

                                  /* if (subChild != null) {
                                    child = body(subChild);
                                  } */

                                  return subChild!;
                                })

                            /*   ListView.builder(
                                itemCount: 10,
                                itemBuilder: (context, item) =>
                                    const BillsItem())
                        */

                            ))),
              ],
            )));
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
