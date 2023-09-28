import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:spavation/app/theme.dart';
import 'package:spavation/core/cache/cache.dart';
import 'package:spavation/core/utils/app_styles.dart';
import 'package:spavation/core/utils/size_config.dart';
import 'package:spavation/features/reservation/presentation/widgets/reservation_item.dart';

import '../../../salons/presentation/screens/widgets/salon_error_widget.dart';
import '../../../salons/presentation/screens/widgets/salon_loadig_widget.dart';
import '../bloc/reservation_bloc.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  late ReservationBloc _reservationBloc;
  String token = '';

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
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<ReservationBloc, ReservationState>(
            listener: (context, state) {},
            listenWhen: (prev, curr) => prev.status != curr.status,
            buildWhen: (prev, curr) => prev.status != curr.status,
            builder: (context, state) {
              Widget? child;
              Widget? subChild;

              child = body(subChild);

              if (state.status == FormzSubmissionStatus.inProgress) {
                subChild = const SalonShimmer();
              }
              if (state.status == FormzSubmissionStatus.failure) {
                subChild = const SalonErrorWidget();
              }

              if (state.status == FormzSubmissionStatus.initial) {
                subChild = const SalonShimmer();
              }

              if (state.reservations == []) {
                subChild = const Text('No salon found ');
              }
              if (state.reservations != null && state.reservations != []) {
                subChild = ListView.builder(
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: state.reservations?.length,
                    itemBuilder: (context, item) => const ReservationItem());
              }

              if (subChild != null) {
                child = body(subChild);
              }

              return child;
            }));
  }

  Widget body(Widget? subChild) {
    return SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Stack(children: [
          // (sh! * 0.8).heightXBox,
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
                      'Reservations',
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
