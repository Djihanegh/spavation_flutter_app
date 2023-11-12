import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spavation/core/enum/enum.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/core/utils/navigation.dart';
import 'package:spavation/core/widgets/app_snack_bar.dart';
import 'package:spavation/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../app/theme.dart';
import '../../../../../core/cache/cache.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/validators.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../settings/presentation/screens/update_user/widgets/custom_text_field.dart';
import '../otp/otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();


  String emailValidator = '';

  bool get canLogin => phoneController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state.action == RequestType.loginUser) {
            if (state.status == AuthenticationStatus.failure) {
              openSnackBar(
                  context, state.errorMessage, AnimatedSnackBarType.error);

              if (state.errorMessage == 'Your account is not verified') {
                context
                    .read<AuthenticationBloc>()
                    .add(ResendOtpEvent(email: phoneController.text));

                navigateToPage(
                    OtpScreen(
                      email: phoneController.text,
                    ),
                    context);
              }
            }

            if (state.status == AuthenticationStatus.success &&
                state.action == RequestType.loginUser) {
              saveUserData(state.name);
              navigateToPage(
                  OtpScreen(
                    email: phoneController.text,
                  ),
                  context);
              //   navigateAndRemoveUntil(const Home(), context, false);
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
                        '${l10n.phoneNumber} :',
                        style: TextStyles.inter
                            .copyWith(color: purple[2], fontSize: 16),
                      ),
                      CustomTextFormField(
                        controller: phoneController,
                        borderColor: purple[2],
                        onSaved: (e) {
                          context
                              .read<AuthenticationBloc>()
                              .add(PhoneChanged(phone: e));
                        },
                        onEditingComplete: () {
                          context
                              .read<AuthenticationBloc>()
                              .add(PhoneChanged(phone: phoneController.text));
                        },
                        onFieldSubmitted: () {
                          context
                              .read<AuthenticationBloc>()
                              .add(PhoneChanged(phone: phoneController.text));
                        },
                        onChanged: (e) => validateEmail(e),
                        keyboardType: TextInputType.phone,
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

              20.heightXBox,
              AppButton(
                isLoading: state.status ==
                    AuthenticationStatus.inProgress
                    ? true
                    : false,
                title: l10n.login,
                color: canLogin ? purple[2] : grey[0],
                borderColor: canLogin ? purple[2] : grey[0],
                textColor:
                    canLogin ? Colors.white : Colors.grey.withOpacity(0.5),
                onPressed: () {
                  if (canLogin) {
                    context.read<AuthenticationBloc>().add(LoginUserEvent(
                          phone: phoneController.text,
                        ));
                  }
                },
              ),
              10.heightXBox,
              /*  Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                    left: 25,
                  ),
                  child: GestureDetector(
                      onTap: () =>
                          navigateToPage(const ForgetPasswordScreen(), context),
                      child: AutoSizeText(
                        l10n.forgetPassword,
                        style: TextStyles.inter
                            .copyWith(color: purple[2], fontSize: 14),
                      ))) */
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

  /* void validatePassword(String password) {
    setState(() {
      if (Validators.isNotEmpty(password) != null) {
        passwordValidator = 'This field should not be empty';
      } else {
        passwordValidator = '';
      }
    });
  }*/

  void saveUserData(String name) {
    Prefs.setString(Prefs.FIRSTNAME, name);
  }
}
