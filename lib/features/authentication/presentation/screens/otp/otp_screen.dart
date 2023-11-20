import 'dart:async';
import 'dart:developer';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/core/utils/navigation.dart';
import 'package:spavation/core/widgets/app_button.dart';
import 'package:spavation/core/widgets/app_snack_bar.dart';
import 'package:spavation/features/authentication/presentation/screens/forgetPassword/update_password_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../app/theme.dart';
import '../../../../../core/enum/enum.dart';
import '../../../../../core/services/location_service.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/constant.dart';
import '../../../../../core/utils/size_config.dart';
import '../../../../../generated/assets.dart';
import '../../../../home/presentation/screens/home/home.dart';
import '../../../../home/presentation/screens/permission/location_permission_screen.dart';
import '../../bloc/authentication_bloc.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.email, required this.phone});

  final String email;
  final String phone;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String otp = '';

  late Timer _timer;
  int _start = 60;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
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

  bool requestPermission = false;

  void checkPermission() async {
    requestPermission = await Location().isLocationServiceEnabled();
  }

  @override
  void initState() {
    checkPermission();
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
    final l10n = AppLocalizations.of(context)!;

    screenSizeInit(context);
    return Scaffold(
        backgroundColor: appPrimaryColor,
        body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if ((state.action == RequestType.resendOtp ||
                      state.action == RequestType.checkOtp) &&
                  state.status == AuthenticationStatus.success) {
                openSnackBar(context, state.successMessage,
                    AnimatedSnackBarType.success);
                if (state.action == RequestType.checkOtp &&
                    state.status == AuthenticationStatus.success) {
                  if (requestPermission) {
                    navigateToPage(const LocationPermissionScreen(), context);
                  } else {
                    navigateAndRemoveUntil(const Home(), context, false);
                  }
                }
              }

              if ((state.action == RequestType.resendOtp ||
                      state.action == RequestType.checkOtp) &&
                  state.status == AuthenticationStatus.failure) {
                openSnackBar(
                    context, state.errorMessage, AnimatedSnackBarType.error);
              }

              if (state.action == RequestType.checkOtpForgetPass) {
                if (state.status == AuthenticationStatus.success) {
                  openSnackBar(context, state.successMessage,
                      AnimatedSnackBarType.success);
                  navigateToPage(UpdatePasswordScreen(otp: otp), context);
                } else if (state.status == AuthenticationStatus.failure) {
                  openSnackBar(
                      context, state.errorMessage, AnimatedSnackBarType.error);
                }
              }
            },
            listenWhen: (prev, curr) => prev.status != curr.status,
            buildWhen: (prev, curr) => prev.status != curr.status,
            builder: (context, state) {
              log(widget.email);
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
                                          widget.key == forgetPasswordKey
                                              ? l10n
                                                  .enterTheForgetPasswordCodeWeSentTo
                                              : l10n.enterTheAuthCode,
                                          style: TextStyles.inter.copyWith(
                                              color: purple[0], fontSize: 15),
                                        ),
                                        Directionality(
                                            textDirection: TextDirection.ltr,
                                            child: AutoSizeText(
                                              widget.phone,
                                              style: TextStyles.inter.copyWith(
                                                  color: Colors.black,
                                                  fontSize: 15),
                                            )),
                                        20.heightXBox,
                                        SizedBox(
                                          height: 80,
                                          child: Center(
                                              child: Directionality(
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  child: OtpTextField(
                                                    numberOfFields: 6,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    disabledBorderColor:
                                                        purple[2],
                                                    enabledBorderColor:
                                                        purple[2],
                                                    focusedBorderColor:
                                                        purple[2],
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(7)),
                                                    borderWidth: 1,

                                                    borderColor: purple[2],
                                                    //set to true to show as box or false to show as dash
                                                    showFieldAsBox: true,
                                                    //runs when a code is typed in
                                                    onCodeChanged:
                                                        (String code) {
                                                      //handle validation or checks here
                                                    },

                                                    //runs when every textfield is filled
                                                    onSubmit: (String
                                                        verificationCode) {
                                                      setState(() {
                                                        otp = verificationCode;
                                                        context
                                                            .read<
                                                                AuthenticationBloc>()
                                                            .add(OtpChanged(
                                                              otp: otp,
                                                            ));
                                                      });
                                                    }, // end onSubmit
                                                  ))),
                                        ),
                                        30.heightXBox,
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20, right: 20),
                                            child: AppButton(
                                                isLoading: state.status ==
                                                        AuthenticationStatus
                                                            .inProgress
                                                    ? true
                                                    : false,
                                                title: l10n.verify,
                                                onPressed: () {
                                                  widget.key ==
                                                          forgetPasswordKey
                                                      ? context
                                                          .read<
                                                              AuthenticationBloc>()
                                                          .add(
                                                              CheckForgetPasswordOtp(
                                                                  otp: otp,
                                                                  email: state
                                                                      .email))
                                                      : context
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
                                              isLoading: false,
                                              title: l10n.back,
                                              color: Colors.white,
                                              textColor: appPrimaryColor,
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            )),
                                        15.heightXBox,
                                        widget.key == forgetPasswordKey
                                            ? emptyWidget()
                                            : _start != 0
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        l10n.resendCodeIn,
                                                        style: TextStyles.inter
                                                            .copyWith(
                                                                color:
                                                                    purple[2],
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
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
                                                              email: widget
                                                                  .phone));
                                                    },
                                                    child: Text(
                                                      "${l10n.resendCode} ",
                                                      style: TextStyles.inter
                                                          .copyWith(
                                                              color: purple[2],
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
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
