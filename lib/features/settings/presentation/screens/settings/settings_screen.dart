import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spavation/app/theme.dart';
import 'package:spavation/core/cache/cache.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/core/utils/app_styles.dart';
import 'package:spavation/core/utils/navigation.dart';
import 'package:spavation/features/authentication/presentation/screens/authentication_screen.dart';
import 'package:spavation/features/settings/presentation/screens/bills/bills_screen.dart';
import 'package:spavation/features/settings/presentation/screens/call_center/call_center_screen.dart';
import 'package:spavation/features/settings/presentation/screens/delete_account/delete_account_screen.dart';
import 'package:spavation/features/settings/presentation/screens/update_user/update_user_information_screen.dart';
import 'package:spavation/generated/assets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/utils/size_config.dart';
import '../../../../localization/domain/entities/language.dart';
import '../../../../localization/presentation/bloc/language_bloc.dart';
import 'widgets/exit_dialog.dart';
import 'widgets/settings_item.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  PageController pageController = PageController(initialPage: 0);

  String firstName = '';

  @override
  void initState() {
    firstName = Prefs.getString(Prefs.FIRSTNAME) ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenSizeInit(context);

    return Scaffold(
      body: BlocConsumer<LanguageBloc, LanguageState>(
          listener: (context, state) {},
          buildWhen: (prev, curr) =>
              prev.selectedLanguage != curr.selectedLanguage,
          builder: (context, state) {
            return SingleChildScrollView(
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
                              firstName,
                              style: TextStyles.inter.copyWith(
                                  color: appPrimaryColor,
                                  fontWeight: FontWeight.w700),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      Prefs.setString(Prefs.LANGUAGE, 'ar');
                                      context.read<LanguageBloc>().add(
                                            ChangeLanguage(
                                              selectedLanguage:
                                                  Language.values[1],
                                            ),
                                          );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: state.selectedLanguage.value ==
                                                  Language.values[1].value
                                              ? appPrimaryColor
                                              : lightWhite,
                                          borderRadius:
                                              BorderRadius.circular(13)),
                                      padding: const EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          top: 5,
                                          bottom: 5),
                                      child: AutoSizeText(
                                        'Ar',
                                        style: TextStyles.inter.copyWith(
                                            color:
                                                state.selectedLanguage.value ==
                                                        Language.values[1].value
                                                    ? Colors.white
                                                    : lightPurple),
                                      ),
                                    )),
                                10.widthXBox,
                                GestureDetector(
                                    onTap: () {
                                      Prefs.setString(Prefs.LANGUAGE, 'en');
                                      context.read<LanguageBloc>().add(
                                          const  ChangeLanguage(
                                              selectedLanguage:
                                                  Language.english,
                                            ),
                                          );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: state.selectedLanguage.value ==
                                              Language.english.value
                                              ? appPrimaryColor
                                              : lightWhite,
                                          borderRadius:
                                              BorderRadius.circular(13)),
                                      padding: const EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          top: 5,
                                          bottom: 5),
                                      child: AutoSizeText(
                                        'En',
                                        style: TextStyles.inter
                                            .copyWith(color:  state.selectedLanguage.value ==
                                            Language.english.value
                                            ? Colors.white
                                            : lightPurple),
                                      ),
                                    ))
                              ],
                            ),
                          ],
                        )
                      ],
                    )),
                Container(
                    width: sw!,
                    height: sh! * 0.62,
                    margin: const EdgeInsets.only(bottom: 0),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25)),
                      color: appPrimaryColor,
                    ),
                    child: PageView(
                      allowImplicitScrolling: true,
                      scrollDirection: Axis.vertical,
                      controller: pageController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        settingsItem(context),
                        UpdateUserInfoScreen(
                          onPageChanged: () {
                            pageController.jumpToPage(0);
                          },
                        )
                      ],
                    ))
              ],
            ));
          }),
    );
  }

  Widget settingsItem(BuildContext cxt) {
    final l10n = AppLocalizations.of(context)!;

    return ListView(
        scrollDirection: Axis.vertical,
        //  controller: pageController,
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          SettingsItem(
              icon: Assets.iconsAwesomeUser,
              name: l10n.account,
              onPressed: () => pageController.jumpToPage(1)),
          SettingsItem(
            icon: Assets.iconsMaterialPayment,
            name: l10n.paymentMethod,
            onPressed: () {},
          ),
          SettingsItem(
              icon: Assets.iconsMetroHistory,
              name: l10n.bills,
              onPressed: () => navigateToPage(const BillsScreen(), context)),
          SettingsItem(
              icon: Assets.iconsAwesomeHeadset,
              name: l10n.contactUs,
              onPressed: () =>
                  navigateToPage(const CallCenterScreen(), context)),
          SettingsItem(
              icon: Assets.iconsIonicIosSettings,
              name: l10n.setting,
              onPressed: () =>
                  navigateToPage(const DeleteAccountScreen(), context)),
          SettingsItem(
            icon: Assets.iconsMetroExit,
            name: l10n.exit,
            onPressed: () => showExitDialog(
                context: cxt,
                onCancel: () => cancel(),
                onContinue: () => logOut()),
          )
        ]);
  }

  List<Widget> pages = [
    UpdateUserInfoScreen(
      onPageChanged: () {},
    ),
    UpdateUserInfoScreen(
      onPageChanged: () {},
    ),
    const BillsScreen(),
    const CallCenterScreen(),
    const DeleteAccountScreen()
  ];

  void logOut() {
    popWithRoot(context);
    Prefs.setString(Prefs.TOKEN, '');
    pushAndRemoveUntil(const AuthenticationScreen(), context);
  }

  void cancel() {
    popWithRoot(context);
  }
}
