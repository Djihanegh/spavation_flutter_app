import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:spavation/core/widgets/navigate_next_btn.dart';
import 'package:spavation/features/settings/presentation/screens/call_center/widgets/call_center_item.dart';
import 'package:spavation/generated/assets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../app/theme.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/size_config.dart';
import '../../../../../core/widgets/custom_back_button.dart';

class CallCenterScreen extends StatefulWidget {
  const CallCenterScreen({
    super.key,
  });

  @override
  State<CallCenterScreen> createState() => _CallCenterScreenState();
}

class _CallCenterScreenState extends State<CallCenterScreen> {
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
                            l10n.callCenter,
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
                      child: ListView(
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
                            CallCenterItem(
                                icon: Assets.iconsAwesomeHeadset,
                                name: l10n.contactUs,
                                onPressed: () {}),
                            /* CallCenterItem(
                                icon: null,
                                name: l10n.question,
                                onPressed: () {}),*/
                            CallCenterItem(
                                icon: null,
                                name: l10n.technicalQuestion,
                                onPressed: () {}),
                            CallCenterItem(
                                icon: null,
                                name: l10n.aboutSpavation,
                                onPressed: () {}),
                            CallCenterItem(
                                icon: null,
                                name: l10n.termsOfService,
                                onPressed: () {})
                          ]),
                    )),
                const NavigateNextButton(),
              ],
            )));
  }
}
