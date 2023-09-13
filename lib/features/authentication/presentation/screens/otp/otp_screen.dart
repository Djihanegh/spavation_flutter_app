import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';

import '../../../../../app/theme.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/size_config.dart';
import '../../../../../generated/assets.dart';
import '../../bloc/authentication_bloc.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    screenSizeInit(context);
    return Scaffold(
        backgroundColor: appPrimaryColor,
        body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {},
            listenWhen: (prev, curr) => prev.status != curr.status,
            buildWhen: (prev, curr) => prev.status != curr.status,
            builder: (context, state) {
              return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Center(
                      child: Stack(alignment: Alignment.center, children: [
                    Padding(
                        padding: EdgeInsets.only(top: sh! * 0.1),
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
                              Container(
                                  width: sw! * 0.96,
                                  padding: paddingAll(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: []))
                            ]))
                  ])));
            }));
  }
}
