import 'dart:developer';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/core/utils/constant.dart';

import '../../../../../app/theme.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_snack_bar.dart';
import '../../../../settings/presentation/screens/update_user/widgets/custom_text_field.dart';
import '../../../data/models/user_model.dart';
import '../../bloc/authentication_bloc.dart';
import '../widgets/drop_down_list.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state.status == FormzSubmissionStatus.failure) {
            openSnackBar(
                context, state.errorMessage, AnimatedSnackBarType.error);
          }

          if (state.status == FormzSubmissionStatus.success) {
            openSnackBar(context, 'User Successfully created !',
                AnimatedSnackBarType.success);
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
          log('GENDERRRRRRRRRRRRRR REGISTERRRRRR');
          log(state.gender.toString());
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
                        'Full name :',
                        style: TextStyles.inter
                            .copyWith(color: purple[2], fontSize: 16),
                      ),
                      CustomTextFormField(
                        controller: nameController,
                        borderColor: purple[2],
                        onSaved: (e) {},
                        onChanged: (e) {},
                      ),
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
                        'Phone number :',
                        style: TextStyles.inter.copyWith(
                          color: purple[2],
                          fontSize: 16,
                        ),
                      ),
                      CustomTextFormField(
                        controller: mobileController,
                        onSaved: (e) {},
                        borderColor: purple[2],
                        onChanged: (e) {},
                        keyboardType: TextInputType.phone,
                      ),
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
                        'Email :',
                        style: TextStyles.inter
                            .copyWith(color: purple[2], fontSize: 16),
                      ),
                      CustomTextFormField(
                        controller: emailController,
                        borderColor: purple[2],
                        onSaved: (e) {},
                        onChanged: (e) {},
                        keyboardType: TextInputType.emailAddress,
                      ),
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
                        'Password :',
                        style: TextStyles.inter
                            .copyWith(color: purple[2], fontSize: 16),
                      ),
                      CustomTextFormField(
                        controller: passwordController,
                        borderColor: purple[2],
                        obscureText: true,
                        onSaved: (e) {},
                        onChanged: (e) {},
                        keyboardType: TextInputType.emailAddress,
                      ),
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
                        'Confirm password :',
                        style: TextStyles.inter
                            .copyWith(color: purple[2], fontSize: 16),
                      ),
                      CustomTextFormField(
                        controller: confirmPasswordController,
                        borderColor: purple[2],
                        obscureText: true,
                        onSaved: (e) {},
                        onChanged: (e) {},
                        keyboardType: TextInputType.emailAddress,
                      ),
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
                          'Select gender :',
                          style: TextStyles.inter
                              .copyWith(color: purple[2], fontSize: 16),
                        ),
                        10.heightXBox,
                        Align(
                            alignment: Alignment.centerLeft,
                            child: DropdownButtonExample(onChanged: (e) {
                              setState(() {
                                gender = e ?? '';
                                log(e.toString());
                                log('?????????????????????????');
                                context
                                    .read<AuthenticationBloc>()
                                    .add(GenderChanged(gender: e ?? ''));
                              });
                            })),
                      ])),
              20.heightXBox,
              AppButton(
                title: 'Register',
                color: purple[2],
                textColor: Colors.white,
                onPressed: () {
                  log(state.gender.toString());
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
                },
              )
            ],
          );
        });
  }
}