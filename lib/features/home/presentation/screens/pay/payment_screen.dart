import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';

import '../../../../../app/theme.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/size_config.dart';
import '../../../../../core/widgets/custom_back_button.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    screenSizeInit(context);
    return Scaffold(
        backgroundColor: appPrimaryColor,
        body: SingleChildScrollView(
            child: Center(
                child: Stack(alignment: Alignment.center, children: [
          Padding(
              padding: EdgeInsets.only(top: sh! * 0.15),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          '',
                          style: TextStyles.inter
                              .copyWith(color: Colors.white, fontSize: 15),
                        ),
                        AutoSizeText(
                          'Request Review',
                          style: TextStyles.inter
                              .copyWith(color: Colors.white, fontSize: 20),
                        ),
                        const Align(
                            alignment: Alignment.centerRight,
                            child: CustomBackButton()),
                      ],
                    ),
                    10.heightXBox,
                    Container(
                        height: sh! * 0.25,
                        width: sw! * 0.98,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(15)),
                        child: Stack(children: [
                          Container(
                            height: sh! * 0.25,
                            width: sw! * 0.95,
                            margin: paddingAll(10),
                            decoration: BoxDecoration(
                                boxShadow: boxShadow,
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                          )
                        ]))
                  ]))
        ]))));
  }
}
