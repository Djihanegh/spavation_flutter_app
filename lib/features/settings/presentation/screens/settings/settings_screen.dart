import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spavation/app/theme.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/core/utils/app_styles.dart';
import 'package:spavation/core/utils/navigation.dart';
import 'package:spavation/features/settings/presentation/screens/bills/bills_screen.dart';
import 'package:spavation/features/settings/presentation/screens/call_center/call_center_screen.dart';
import 'package:spavation/features/settings/presentation/screens/delete_account/delete_account_screen.dart';
import 'package:spavation/features/settings/presentation/screens/update_user/update_user_information_screen.dart';
import 'package:spavation/generated/assets.dart';

import '../../../../../core/utils/size_config.dart';
import 'widgets/settings_item.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    screenSizeInit(context);
    return Scaffold(
      body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (sh! * 0.1).heightXBox,
              Padding(
                  padding: paddingAll(30),
                  child: Row(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        padding: paddingAll(10),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: appPrimaryColor),
                        child: SvgPicture.asset(
                          Assets.iconsLogo,
                          height: 20,
                          width: 20,
                        ),
                      ),
                      30.widthXBox,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            'User 1',
                            style: TextStyles.inter.copyWith(
                                color: appPrimaryColor,
                                fontWeight: FontWeight.w700),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: lightWhite,
                                    borderRadius: BorderRadius.circular(13)),
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 5, bottom: 5),
                                child: AutoSizeText(
                                  'Ar',
                                  style: TextStyles.inter
                                      .copyWith(color: lightPurple),
                                ),
                              ),
                              10.widthXBox,
                              Container(
                                decoration: BoxDecoration(
                                    color: appPrimaryColor,
                                    borderRadius: BorderRadius.circular(13)),
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 5, bottom: 5),
                                child: AutoSizeText(
                                  'En',
                                  style: TextStyles.inter
                                      .copyWith(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  )),
              Container(
                  width: sw!,
                  height: sh! * 0.8,
                  margin: const EdgeInsets.only(bottom: 0),
                  decoration: const BoxDecoration(
                    //  boxShadow: boxShadow2,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                    color: appPrimaryColor,
                  ),
                  child: PageView(
                    allowImplicitScrolling: true,
                    scrollDirection: Axis.vertical,
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [settingsItem(), const UpdateUserInfoScreen()],
                  ))
            ],
          )),
    );
  }

  Widget settingsItem() => ListView(
          scrollDirection: Axis.vertical,
          //  controller: pageController,
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            SettingsItem(
                icon: Assets.iconsAwesomeUser,
                name: 'Account',
                onPressed: () => pageController.jumpToPage(1)),
            SettingsItem(
              icon: Assets.iconsMaterialPayment,
              name: 'Payment method',
              onPressed: () {},
            ),
            SettingsItem(
                icon: Assets.iconsMetroHistory,
                name: 'Bills',
                onPressed: () => navigateToPage(const BillsScreen(), context)),
            SettingsItem(
                icon: Assets.iconsAwesomeHeadset,
                name: 'Contact us',
                onPressed: () =>
                    navigateToPage(const CallCenterScreen(), context)),
            SettingsItem(
                icon: Assets.iconsIonicIosSettings,
                name: 'Setting',
                onPressed: () =>
                    navigateToPage(const DeleteAccountScreen(), context)),
            SettingsItem(
              icon: Assets.iconsMetroExit,
              name: 'Exit',
              onPressed: () {},
            )
          ]);

  List<Widget> pages = const [
    UpdateUserInfoScreen(),
    UpdateUserInfoScreen(),
    BillsScreen(),
    CallCenterScreen(),
    DeleteAccountScreen()
  ];
}
