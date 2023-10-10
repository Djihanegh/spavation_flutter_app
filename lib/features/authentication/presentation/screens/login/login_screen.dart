import 'dart:developer';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:spavation/core/enum/enum.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/core/utils/navigation.dart';
import 'package:spavation/core/widgets/app_snack_bar.dart';
import 'package:spavation/features/authentication/presentation/bloc/authentication_bloc.dart';

import '../../../../../app/theme.dart';
import '../../../../../core/cache/cache.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/validators.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../home/presentation/screens/home/home.dart';
import '../../../../settings/presentation/screens/update_user/widgets/custom_text_field.dart';
import '../otp/otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String emailValidator = '', passwordValidator = '';

  bool get canLogin =>
      emailController.text.isNotEmpty && passwordController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state.action == RequestType.loginUser) {
            if (state.status == FormzSubmissionStatus.failure) {
              openSnackBar(
                  context, state.errorMessage, AnimatedSnackBarType.error);

              if (state.errorMessage == 'Your account is not verified') {
                context
                    .read<AuthenticationBloc>()
                    .add(ResendOtpEvent(email: emailController.text));

                navigateToPage(const OtpScreen(), context);
              }
            }

            if (state.status == FormzSubmissionStatus.success &&
                state.action == RequestType.loginUser) {
              saveUserData(state.name);
              navigateAndRemoveUntil(const Home(), context , false);
            }
          }
        },
        listenWhen: (prev, curr) => prev.status != curr.status,
        buildWhen: (prev, curr) =>
            prev.status != curr.status || prev.email != curr.email,
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.heightXBox,
              Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        'Email :',
                        style: TextStyles.inter
                            .copyWith(color: purple[2], fontSize: 16),
                      ),
                      CustomTextFormField(
                        controller: emailController,
                        borderColor: purple[2],
                        onSaved: (e) {
                          context
                              .read<AuthenticationBloc>()
                              .add(EmailChanged(email: e));
                        },
                        onEditingComplete: () {
                          context
                              .read<AuthenticationBloc>()
                              .add(EmailChanged(email: emailController.text));
                        },
                        onFieldSubmitted: () {
                          context
                              .read<AuthenticationBloc>()
                              .add(EmailChanged(email: emailController.text));
                        },
                        onChanged: (e) => validateEmail(e),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      emailValidator.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(10),
                              child: SizedBox(
                                  width: double.infinity,
                                  child: Text(emailValidator,
                                      style:
                                          const TextStyle(color: Colors.red))))
                          : const SizedBox(),
                    ],
                  )),
              Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        'Password :',
                        style: TextStyles.inter
                            .copyWith(color: purple[2], fontSize: 16),
                      ),
                      CustomTextFormField(
                        controller: passwordController,
                        borderColor: purple[2],
                        obscureText: true,
                        onSaved: (e) {},
                        onChanged: (e) {
                          validatePassword(e);
                          context
                              .read<AuthenticationBloc>()
                              .add(PasswordChanged(password: e));
                        },
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) => null,
                      ),
                      passwordValidator.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(10),
                              child: SizedBox(
                                  width: double.infinity,
                                  child: Text(passwordValidator,
                                      style:
                                          const TextStyle(color: Colors.red))))
                          : const SizedBox(),
                    ],
                  )),
              20.heightXBox,
              AppButton(
                title: 'Login',
                color: canLogin ? purple[2] : grey[0],
                borderColor: canLogin ? purple[2] : grey[0],
                textColor:
                    canLogin ? Colors.white : Colors.grey.withOpacity(0.5),
                onPressed: () {
                  if (canLogin) {
                    context.read<AuthenticationBloc>().add(LoginUserEvent(
                        password: passwordController.text,
                        email: emailController.text));
                  }
                },
              ),
              10.heightXBox,
              Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                    left: 25,
                  ),
                  child: AutoSizeText(
                    'Forgot password ?',
                    style: TextStyles.inter
                        .copyWith(color: purple[2], fontSize: 14),
                  ))
            ],
          );
        });
  }

  void validateEmail(String email) {
    setState(() {
      if (Validators.isNotEmpty(email) != null) {
        emailValidator = 'This field should not be empty';
      } else {
        emailValidator = '';
      }
    });
  }

  void validatePassword(String password) {
    setState(() {
      if (Validators.isNotEmpty(password) != null) {
        passwordValidator = 'This field should not be empty';
      } else {
        passwordValidator = '';
      }
    });
  }

  void saveUserData(String name) {
    Prefs.setString(Prefs.FIRSTNAME, name);
  }
}
