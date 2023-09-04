import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';

import '../../../../../app/theme.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/size_config.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
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
                            'Setting',
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
                            padding: const EdgeInsets.only(left: 40, top: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(
                                  'X',
                                  style: TextStyles.montserrat.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
                                ),
                                20.widthXBox,
                                AutoSizeText(
                                  'Delete account',
                                  style: TextStyles.montserrat.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14),
                                ),
                              ],
                            )))),
              ],
            )));
  }
}
