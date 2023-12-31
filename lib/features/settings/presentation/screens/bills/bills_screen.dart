import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/cache/cache.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../../../../core/widgets/navigate_next_btn.dart';
import '../../../../reservation/presentation/bloc/reservation_bloc.dart';
import '../../../../../core/widgets/error_widget.dart';
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
  String token = '';

  void _refresh() {
    context.read<ReservationBloc>().add(GetReservationsEvent(token));
  }

  @override
  void initState() {
    token = Prefs.getString(Prefs.TOKEN) ?? '';
    context.read<ReservationBloc>().add(GetReservationsEvent(token));
    super.initState();
  }

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
                            l10n.bills,
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
                        child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20),
                            child:
                                BlocConsumer<ReservationBloc, ReservationState>(
                                    listener: (context, state) {},
                                    listenWhen: (prev, curr) =>
                                        prev.status != curr.status,
                                    builder: (context, state) {
                                      Widget? subChild;

                                      if (state.status ==
                                          ReservationStatus.failure) {
                                        subChild = CustomErrorWidget(
                                          onRefresh: () => _refresh(),
                                          errorMessage: state.errorMessage,
                                        );
                                      }

                                      if (state.status ==
                                              ReservationStatus.initial ||
                                          state.status ==
                                              ReservationStatus.inProgress) {
                                        subChild = const LoadingWidget();
                                      }

                                      if (state.reservations != null) {
                                        if (state.reservations!.isNotEmpty) {
                                          subChild = ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const AlwaysScrollableScrollPhysics(),
                                              itemCount:
                                                  state.reservations?.length,
                                              itemBuilder: (context, indexA) {
                                                return BillsItem(
                                                  reservationModel: state
                                                      .reservations![indexA],
                                                );
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

                                      return subChild!;
                                    })))),
                const NavigateNextButton(),
              ],
            )));
  }
}
