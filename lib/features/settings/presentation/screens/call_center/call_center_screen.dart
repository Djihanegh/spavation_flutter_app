import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:spavation/features/settings/presentation/screens/call_center/widgets/call_center_item.dart';
import 'package:spavation/generated/assets.dart';

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
                Positioned(
                    top: (sh! * 0.12),
                    right: 0,
                    child: GestureDetector(
                      child: const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                CustomBackButton(),
                              ],
                            ),
                          ]),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    )),
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
                              'Call Center',
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
                      child: ListView(
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
                            CallCenterItem(
                                icon: Assets.iconsAwesomeHeadset,
                                name: 'Contact us',
                                onPressed: () {}),
                            CallCenterItem(
                                icon: null, name: 'Question', onPressed: () {}),
                            CallCenterItem(
                                icon: null,
                                name: 'Technical Question',
                                onPressed: () {}),
                            CallCenterItem(
                                icon: null,
                                name: 'About Spavation',
                                onPressed: () {}),
                            CallCenterItem(
                                icon: null,
                                name: 'Terms of Service',
                                onPressed: () {})
                          ]),
                    )),
              ],
            )));
  }
}
