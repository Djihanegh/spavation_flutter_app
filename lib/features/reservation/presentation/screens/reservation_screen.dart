import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spavation/app/theme.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/core/utils/app_styles.dart';
import 'package:spavation/core/utils/size_config.dart';
import 'package:spavation/features/reservation/presentation/widgets/reservation_item.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  @override
  Widget build(BuildContext context) {
    screenSizeInit(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Stack(
              children: [
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
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: 10,
                          itemBuilder: (context, item) =>
                              const ReservationItem()),
                    )),
              ],
            )));
  }
}
