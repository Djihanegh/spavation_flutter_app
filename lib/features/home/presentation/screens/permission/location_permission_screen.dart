import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/core/utils/navigation.dart';
import 'package:spavation/core/widgets/app_button.dart';
import 'package:spavation/features/home/presentation/screens/home/home.dart';

import '../../../../../app/theme.dart';
import '../../../../../core/services/location_service.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/size_config.dart';
import '../../../../../core/widgets/custom_back_button.dart';
import '../../../../../generated/assets.dart';
import '../../../../../localization.dart';

class LocationPermissionScreen extends StatefulWidget {
  const LocationPermissionScreen({super.key});

  @override
  State<LocationPermissionScreen> createState() =>
      _LocationPermissionScreenState();
}

class _LocationPermissionScreenState extends State<LocationPermissionScreen> {
  @override
  Widget build(BuildContext context) {
    screenSizeInit(context);
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
        backgroundColor: appPrimaryColor,
        body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Center(
                child: Stack(alignment: Alignment.center, children: [
              Padding(
                padding: EdgeInsets.only(top: sh! * 0.06),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Align(
                                  alignment: Alignment.topCenter,
                                  child: SvgPicture.asset(
                                    Assets.iconsLogo,
                                    height: 100,
                                    width: 100,
                                  ))),
                        ],
                      ),
                      10.heightXBox,
                      AutoSizeText(
                        'Spavation',
                        style: TextStyles.inter.copyWith(
                            fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                      AutoSizeText(
                        l10n.locationPermission,
                        style: TextStyles.inter.copyWith(
                            fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                      10.heightXBox,
                      Container(
                          width: sw! * 0.96,
                          padding: paddingAll(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(Assets.imagesImage2),
                                AutoSizeText(
                                  l10n.locationPermission,
                                  style: TextStyles.inter.copyWith(
                                      color: purple[2],
                                      fontWeight: FontWeight.w700,
                                      fontSize: 29),
                                ),
                                5.heightXBox,
                                AutoSizeText(
                                  l10n.grantUsLocation,
                                  textAlign: TextAlign.center,
                                  style: TextStyles.inter.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                ),
                                40.heightXBox,
                                AppButton(
                                    title: l10n.turnOnLocation,
                                    color: purple[2],
                                    textColor: Colors.white,
                                    onPressed: () {
                                      Location()
                                          .determinePosition(context)
                                          .then((value) {
                                        navigateAndRemoveUntil(
                                            const Home(), context, false);
                                      });
                                    },
                                    isLoading: false),
                                10.heightXBox,
                                AppButton(
                                  title: l10n.notNow.toUpperCase(),
                                  color: Colors.white,
                                  textColor: appPrimaryColor,
                                  isLoading: false,
                                  borderColor: purple[2],
                                  onPressed: () {
                                    navigateAndRemoveUntil(
                                        const Home(), context, false);
                                  },
                                ),
                                10.heightXBox,
                              ])),
                    ]),
              ),
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
            ]))));
  }
}
