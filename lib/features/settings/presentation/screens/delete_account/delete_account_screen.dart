import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:spavation/core/enum/enum.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/features/localization/domain/entities/language.dart';
import 'package:spavation/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../app/theme.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/size_config.dart';
import '../../../../../core/widgets/custom_back_button.dart';
import '../../../../../core/widgets/navigate_next_btn.dart';
import '../../../../localization/presentation/bloc/language_bloc.dart';
import 'widgets/delete_account_dialog.dart';
import '../../../../../core/cache/cache.dart';
import '../../../../../core/utils/navigation.dart';
import '../../../../authentication/presentation/screens/authentication_screen.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  String token = '';

  @override
  void initState() {
    token = Prefs.getString(Prefs.TOKEN) ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    screenSizeInit(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<LanguageBloc, LanguageState>(
            listener: (context, language) {},
            buildWhen: (prev, curr) =>
                prev.selectedLanguage != curr.selectedLanguage,
            builder: (context, language) {
              return SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: BlocConsumer<SettingsBloc, SettingsState>(
                      listener: (context, state) {
                        if (state.status == FormzSubmissionStatus.success &&
                            state.action == RequestType.deleteUser) {
                          cancel();
                          clearUserData();
                          pushAndRemoveUntil(
                              const AuthenticationScreen(), context);
                        }
                      },
                      listenWhen: (prev, curr) => prev.status != curr.status,
                      buildWhen: (prev, curr) => prev.status != curr.status,
                      builder: (context, state) {
                        return Stack(
                          children: [
                            Container(
                              height: sh!,
                              color: Colors.white,
                            ),
                            const NavigateNextButton(),
                            GestureDetector(
                              child: Padding(
                                  padding: EdgeInsets.only(top: sh! * 0.1),
                                  child: Container(
                                    width: sw!,
                                    height: sh! * 0.2,
                                    decoration: BoxDecoration(
                                      boxShadow: boxShadow2,
                                      borderRadius: BorderRadius.circular(25),
                                      color: appPrimaryColor.withOpacity(0.22),
                                    ),
                                    child: Padding(
                                        padding:
                                            EdgeInsets.only(top: sh! * 0.05),
                                        child: AutoSizeText(
                                          l10n.setting,
                                          style: TextStyles.inter.copyWith(
                                              fontSize: 40,
                                              color: appPrimaryColor,
                                              fontWeight: FontWeight.w700),
                                          textAlign: TextAlign.center,
                                        )),
                                  )),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                            Positioned(
                                top: sh! * 0.25,
                                bottom: 0,
                                child: GestureDetector(
                                    onTap: () => showDeleteAccountDialog(
                                        context: context,
                                        onCancel: () => cancel(),
                                        onContinue: () => delete()),
                                    child: Container(
                                        width: sw!,
                                        height: sh!,
                                        margin:
                                            const EdgeInsets.only(bottom: 80),
                                        decoration: const BoxDecoration(
                                          //  boxShadow: boxShadow2,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(25),
                                              topRight: Radius.circular(25)),
                                          color: appPrimaryColor,
                                        ),
                                        child: Padding(
                                            padding: language.selectedLanguage
                                                        .value ==
                                                    Language.english.value
                                                ? const EdgeInsets.only(
                                                    left: 40, top: 40)
                                                : const EdgeInsets.only(
                                                    right: 40, top: 40),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AutoSizeText(
                                                  'X',
                                                  style: TextStyles.montserrat
                                                      .copyWith(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 14),
                                                ),
                                                20.widthXBox,
                                                AutoSizeText(
                                                  l10n.deleteAccount,
                                                  style: TextStyles.montserrat
                                                      .copyWith(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          fontSize: 14),
                                                ),
                                              ],
                                            ))))),
                          ],
                        );
                      }));
            }));
  }

  void clearUserData() {
    Prefs.setString(Prefs.TOKEN, '');
    Prefs.setString(Prefs.FIRSTNAME, '');
  }

  void delete() {
    context.read<SettingsBloc>().add(DeleteUserEvent(token));
  }

  void cancel() {
    popWithRoot(context);
  }
}
