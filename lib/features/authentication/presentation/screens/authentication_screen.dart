import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/generated/assets.dart';

import '../../../../app/theme.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/size_config.dart';
import '../bloc/authentication_bloc.dart';
import 'login/login_screen.dart';
import 'register/register_screen.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool isLoginVisible = true;

  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    screenSizeInit(context);
    return Scaffold(
        backgroundColor: appPrimaryColor,
        body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {

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
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Center(
                      child: Stack(
                    alignment: Alignment.center,
                    children: [
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
                              AutoSizeText(
                                'Spavation',
                                style: TextStyles.inter.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                              AutoSizeText(
                                isLoginVisible ? 'Create an account' : 'Login',
                                style: TextStyles.inter.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
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
                                        SizedBox(
                                            width:
                                                !isLoginVisible ? 150 : 160,
                                            child: Stack(
                                              children: [

                                                if (isLoginVisible)
                                                  GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          isLoginVisible =
                                                              !isLoginVisible;
                                                        });
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 20,
                                                                right: 20,
                                                                top: 10,
                                                                bottom: 10),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            color: grey[0]),
                                                        width: 400,
                                                        child: AutoSizeText(
                                                          'Register',
                                                          style: TextStyles
                                                              .inter
                                                              .copyWith(
                                                                  color:
                                                                      appPrimaryColor,
                                                                  fontSize: 14),
                                                          textAlign:
                                                              TextAlign.right,
                                                        ),
                                                      )),
                                                if (!isLoginVisible)
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        isLoginVisible =
                                                        !isLoginVisible;
                                                      });
                                                    },
                                                    child: Container(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          left: 10,
                                                          right: 50,
                                                          top: 10,
                                                          bottom: 10),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(20),
                                                          color: grey[0]),
                                                      child: AutoSizeText(
                                                        'Login',
                                                        style: TextStyles.inter
                                                            .copyWith(
                                                            color:
                                                            appPrimaryColor,
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                  ),
                                                if (!isLoginVisible)
                                                  Positioned(
                                                      right: 0,
                                                      top: 0,
                                                      bottom: 0,
                                                      child: GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              isLoginVisible =
                                                              !isLoginVisible;
                                                            });
                                                          },
                                                          child: Container(
                                                            padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 20,
                                                                right: 20,
                                                                top: 10,
                                                                bottom: 10),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    20),
                                                                color:
                                                                appPrimaryColor),
                                                            height: 50,
                                                            child: Center(
                                                                child:
                                                                AutoSizeText(
                                                                  'Register',
                                                                  style: TextStyles
                                                                      .inter
                                                                      .copyWith(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                      14),
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                )),
                                                          ))),
                                                if (isLoginVisible)
                                                  Positioned(
                                                      left: 0,
                                                      top: 0,
                                                      bottom: 0,
                                                      child: GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              isLoginVisible =
                                                                  !isLoginVisible;
                                                            });
                                                          },
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 20,
                                                                    right: 20,
                                                                    top: 10,
                                                                    bottom: 10),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                color:
                                                                    appPrimaryColor),
                                                            child: AutoSizeText(
                                                              'Login',
                                                              style: TextStyles
                                                                  .inter
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          14),
                                                            ),
                                                          ))),

                                              ],
                                            )),
                                        if (isLoginVisible)
                                          const LoginScreen(),
                                        if (!isLoginVisible)
                                          const RegisterScreen(),

                                        20.heightXBox,



                                      ])),

                              20.heightXBox,
                            ],

                          )),
                      Positioned(
                          top: -10,
                          left: -25,
                          child: Container(
                            height: sh! * 0.17,
                            width: sw! * 0.35,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.35),
                                borderRadius: appCircular),
                          )),
                    ],
                  )));
            }));
  }
}
