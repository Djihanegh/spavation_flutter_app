import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:spavation/core/enum/enum.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/core/utils/navigation.dart';
import 'package:spavation/features/authentication/presentation/screens/otp/otp_screen.dart';
import '../../../../../app/theme.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/validators.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_snack_bar.dart';
import '../../../../settings/presentation/screens/update_user/widgets/custom_text_field.dart';
import '../../../data/models/user_model.dart';
import '../../bloc/authentication_bloc.dart';
import '../widgets/drop_down_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String gender = '';
  String emailValidator = '',
      passwordValidator = '',
      mobileValidator = '',
      confirmPasswordValidator = '',
      nameValidator = '';

  bool get canRegister =>
      nameController.text.isNotEmpty &&
      mobileController.text.isNotEmpty &&
      emailController.text.isNotEmpty &&
      passwordController.text.isNotEmpty &&
      confirmPasswordController.text.isNotEmpty &&
      gender.isNotEmpty &&
      Validators.passwordsMatch(
          passwordController.text, confirmPasswordController.text);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state.action == RequestType.createUser) {
            if (state.status == FormzSubmissionStatus.failure) {
              openSnackBar(
                  context, state.errorMessage, AnimatedSnackBarType.error);
            }

            if (state.status == FormzSubmissionStatus.success) {
              openSnackBar(context, 'User Successfully created !',
                  AnimatedSnackBarType.success);

              navigateToPage(
                  OtpScreen(
                    email: emailController.text,
                  ),
                  context);
              clearTextFields();
            }
          }
        },
        listenWhen: (prev, curr) =>
            prev.status != curr.status ||
            prev.gender != curr.gender ||
            prev.password != curr.password ||
            prev.confirmPassword != curr.confirmPassword,
        buildWhen: (prev, curr) =>
            prev.status != curr.status ||
            prev.gender != curr.gender ||
            prev.password != curr.password ||
            prev.confirmPassword != curr.confirmPassword,
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.heightXBox,
              Padding(
                  padding: const EdgeInsets.only(
                      bottom: 10, left: 10, right: 10, top: 10),
                  // , left: 20, right: 20
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        '${l10n.fullName} :',
                        style: TextStyles.inter
                            .copyWith(color: purple[2], fontSize: 16),
                      ),
                      CustomTextFormField(
                        controller: nameController,
                        borderColor: purple[2],
                        onSaved: (e) {},
                        onChanged: (e) => validateName(e),
                      ),
                      nameValidator.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(10),
                              child: SizedBox(
                                  width: double.infinity,
                                  child: Text(nameValidator,
                                      style:
                                          const TextStyle(color: Colors.red))))
                          : const SizedBox(),
                    ],
                  )),
              Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                  // , left: 20, right: 20
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        '${l10n.phoneNumber} :',
                        style: TextStyles.inter.copyWith(
                          color: purple[2],
                          fontSize: 16,
                        ),
                      ),
                      CustomTextFormField(
                        controller: mobileController,
                        onSaved: (e) {},
                        borderColor: purple[2],
                        onChanged: (e) => validatePhone(e),
                        keyboardType: TextInputType.phone,
                      ),
                      mobileValidator.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(10),
                              child: SizedBox(
                                  width: double.infinity,
                                  child: Text(mobileValidator,
                                      style:
                                          const TextStyle(color: Colors.red))))
                          : const SizedBox(),
                    ],
                  )),
              Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                  // , left: 20, right: 20
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        '${l10n.email} :',
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
                  // , left: 20, right: 20
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        '${l10n.password} :',
                        style: TextStyles.inter
                            .copyWith(color: purple[2], fontSize: 16),
                      ),
                      CustomTextFormField(
                        controller: passwordController,
                        borderColor: purple[2],
                        obscureText: true,
                        onSaved: (e) {},
                        onChanged: (e) => validatePassword(e),
                        keyboardType: TextInputType.emailAddress,
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
              Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                  // , left: 20, right: 20
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        '${l10n.confirmPassword} :',
                        style: TextStyles.inter
                            .copyWith(color: purple[2], fontSize: 16),
                      ),
                      CustomTextFormField(
                        controller: confirmPasswordController,
                        borderColor: purple[2],
                        obscureText: true,
                        onSaved: (e) {},
                        validator: () => null,
                        onChanged: (e) => validateConfirmPassword(
                            passwordController.text,
                            confirmPasswordController.text),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      confirmPasswordValidator.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(10),
                              child: SizedBox(
                                  width: double.infinity,
                                  child: Text(confirmPasswordValidator,
                                      style:
                                          const TextStyle(color: Colors.red))))
                          : const SizedBox(),
                    ],
                  )),
              Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                  // , left: 20, right: 20
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          '${l10n.selectGender} :',
                          style: TextStyles.inter
                              .copyWith(color: purple[2], fontSize: 16),
                        ),
                        10.heightXBox,
                        Align(
                            alignment: Alignment.centerLeft,
                            child: DropdownButtonExample(onChanged: (e) {
                              setState(() {
                                gender = e ?? '';
                                context
                                    .read<AuthenticationBloc>()
                                    .add(GenderChanged(gender: e ?? ''));
                              });
                            })),
                      ])),
              20.heightXBox,
              AppButton(
                title: l10n.register,
                color: canRegister ? purple[2] : grey[0],
                borderColor: canRegister ? purple[2] : grey[0],
                textColor:
                    canRegister ? Colors.white : Colors.grey.withOpacity(0.5),
                onPressed: () {
                  if (canRegister) {
                    context.read<AuthenticationBloc>().add(CreateUserEvent(
                        user: UserModel(
                            name: nameController.text,
                            phone: mobileController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            birthday: '10',
                            latitude: '10',
                            longitude: '10',
                            address: 'Annaba',
                            gender: gender)));
                  }
                },
              )
            ],
          );
        });
  }

  void validateConfirmPassword(String password, String confirmPassword) {
    setState(() {
      if (!Validators.passwordsMatch(password, confirmPassword)) {
        confirmPasswordValidator = "Passwords don't match";
      } else {
        confirmPasswordValidator = '';
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

  void validateEmail(String email) {
    setState(() {
      if (Validators.isNotEmpty(email) != null) {
        emailValidator = 'This field should not be empty';
      } else {
        emailValidator = '';
      }
    });
  }

  void validatePhone(String phone) {
    setState(() {
      if (Validators.isNotEmpty(phone) != null) {
        mobileValidator = 'This field should not be empty';
      } else {
        mobileValidator = '';
      }
    });
  }

  void validateName(String name) {
    setState(() {
      if (Validators.isNotEmpty(name) != null) {
        nameValidator = 'This field should not be empty';
      } else {
        nameValidator = '';
      }
    });
  }

  void clearTextFields() {
    setState(() {
      emailController.clear();
      mobileController.clear();
      nameController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
    });
  }
}
