import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';

import '../../../../app/theme.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../settings/presentation/screens/update_user/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        10.heightXBox,
        Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            // , left: 20, right: 20
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  'Email :',
                  style:
                      TextStyles.inter.copyWith(color: purple[2], fontSize: 16),
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
            padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  'Password :',
                  style:
                      TextStyles.inter.copyWith(color: purple[2], fontSize: 16),
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
        20.heightXBox,
        AppButton(title: 'Login', color: purple[2], textColor: Colors.white),
        10.heightXBox,
        Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              left: 25,
            ),
            child: AutoSizeText(
              'Forgot password ?',
              style: TextStyles.inter.copyWith(color: purple[2], fontSize: 14),
            ))
      ],
    );
  }
}
