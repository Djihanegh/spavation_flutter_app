import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formz/formz.dart';
import 'package:spavation/core/enum/enum.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/core/utils/navigation.dart';
import 'package:spavation/core/widgets/app_snack_bar.dart';
import 'package:spavation/features/authentication/presentation/screens/otp/otp_screen.dart';
import 'package:spavation/features/settings/presentation/screens/update_user/widgets/custom_text_field.dart';

import '../../../../../app/theme.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/constant.dart';
import '../../../../../core/utils/size_config.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../generated/assets.dart';
import '../../bloc/authentication_bloc.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appPrimaryColor,
        body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state.action == RequestType.sendOtpForgetPass &&
                  state.status == FormzSubmissionStatus.success) {
                openSnackBar(context, state.successMessage,
                    AnimatedSnackBarType.success);
                navigateToPage(
                    OtpScreen(
                      key: forgetPasswordKey,
                      email: emailController.text,
                    ),
                    context);
              } else if (state.status == FormzSubmissionStatus.failure) {
                openSnackBar(
                    context, state.errorMessage, AnimatedSnackBarType.error);
              }
            },
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
                                      children: [
                                        30.heightXBox,
                                        AutoSizeText(
                                          'Enter your email below to send you otp code',
                                          style: TextStyles.inter.copyWith(
                                              color: purple[0], fontSize: 15),
                                        ),
                                        20.heightXBox,
                                        CustomTextFormField(
                                          onSaved: () {},
                                          onChanged: (e) {
                                            context
                                                .read<AuthenticationBloc>()
                                                .add(EmailChanged(email: e));
                                          },
                                          hintText: 'Email',
                                          borderColor: appPrimaryColor,
                                          controller: emailController,
                                        ),
                                        30.heightXBox,
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20, right: 20),
                                            child: AppButton(
                                                title: 'Send',
                                                onPressed: () {
                                                  context
                                                      .read<
                                                          AuthenticationBloc>()
                                                      .add(SendForgetPasswordOtp(
                                                          email: emailController
                                                              .text));
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
                                      ]))
                            ]))
                  ])));
            }));
  }
}
