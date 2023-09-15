import 'dart:async';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formz/formz.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/core/widgets/app_button.dart';
import 'package:spavation/core/widgets/app_snack_bar.dart';

import '../../../../../app/theme.dart';
import '../../../../../core/enum/enum.dart';
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
  String otp = '';

  late Timer _timer;
  int _start = 60;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    screenSizeInit(context);
    return Scaffold(
        backgroundColor: appPrimaryColor,
        body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if ((state.action == AuthAction.resendOtp ||
                      state.action == AuthAction.checkOtp) &&
                  state.status == FormzSubmissionStatus.success) {
                openSnackBar(context, state.successMessage,
                    AnimatedSnackBarType.success);
                if (state.action == AuthAction.checkOtp &&
                    state.status == FormzSubmissionStatus.success) {
                  Navigator.pop(context);
                }
              }

              if ((state.action == AuthAction.resendOtp ||
                      state.action == AuthAction.checkOtp) &&
                  state.status == FormzSubmissionStatus.failure) {
                openSnackBar(
                    context, state.errorMessage, AnimatedSnackBarType.error);
              }
            },
            listenWhen: (prev, curr) => prev.status != curr.status,
            buildWhen: (prev, curr) =>
                prev.status != curr.status || prev.email != curr.email,
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
                                      children: [
                                        30.heightXBox,
                                        AutoSizeText(
                                          'Enter the authentication code below we sent to ',
                                          style: TextStyles.inter.copyWith(
                                              color: purple[0], fontSize: 15),
                                        ),
                                        AutoSizeText(
                                          state.email,
                                          style: TextStyles.inter.copyWith(
                                              color: Colors.black,
                                              fontSize: 15),
                                        ),
                                        20.heightXBox,
                                        SizedBox(
                                          height: 80,
                                          child: Center(
                                              child: OtpTextField(
                                            numberOfFields: 6,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            disabledBorderColor: purple[2],
                                            enabledBorderColor: purple[2],
                                            focusedBorderColor: purple[2],
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(7)),
                                            borderWidth: 1,

                                            borderColor: purple[2],
                                            //set to true to show as box or false to show as dash
                                            showFieldAsBox: true,
                                            //runs when a code is typed in
                                            onCodeChanged: (String code) {
                                              //handle validation or checks here
                                            },

                                            //runs when every textfield is filled
                                            onSubmit:
                                                (String verificationCode) {
                                              setState(() {
                                                otp = verificationCode;
                                              });
                                            }, // end onSubmit
                                          )),
                                        ),
                                        30.heightXBox,
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20, right: 20),
                                            child: AppButton(
                                                title: 'Verify',
                                                onPressed: () {
                                                  context
                                                      .read<
                                                          AuthenticationBloc>()
                                                      .add(CheckOtpEvent(
                                                          otp: otp));
                                                },
                                                color: purple[2],
                                                textColor: Colors.white)),
                                        10.heightXBox,
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20, right: 20),
                                            child: AppButton(
                                              title: 'Back',
                                              color: Colors.white,
                                              textColor: appPrimaryColor,
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            )),
                                        15.heightXBox,
                                        _start != 0
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Resend Code in",
                                                    style: TextStyles.inter
                                                        .copyWith(
                                                            color: purple[2],
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    _start.toString(),
                                                    style: TextStyle(
                                                        color: purple[2],
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20),
                                                  ),
                                                ],
                                              )
                                            : GestureDetector(
                                                onTap: () {
                                                  context
                                                      .read<
                                                          AuthenticationBloc>()
                                                      .add(ResendOtpEvent(
                                                          email: state.email));
                                                },
                                                child: Text(
                                                  "Resend code ",
                                                  style: TextStyles.inter
                                                      .copyWith(
                                                          color: purple[2],
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16),
                                                ),
                                              ),
                                        10.heightXBox
                                      ]))
                            ]))
                  ])));
            }));
  }
}
