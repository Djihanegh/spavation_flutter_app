import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:spavation/core/enum/enum.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/features/settings/presentation/bloc/settings_bloc.dart';

import '../../../../../app/theme.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/size_config.dart';
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
    screenSizeInit(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: BlocConsumer<SettingsBloc, SettingsState>(
                listener: (context, state) {
                  if (state.status == FormzSubmissionStatus.success &&
                      state.action == RequestType.deleteUser) {
                    cancel();
                    clearUserData();
                    navigateToPage(const AuthenticationScreen(), context);
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
                      Padding(
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
                                padding: EdgeInsets.only(top: sh! * 0.05),
                                child: AutoSizeText(
                                  'Setting',
                                  style: TextStyles.inter.copyWith(
                                      fontSize: 40,
                                      color: appPrimaryColor,
                                      fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.center,
                                )),
                          )),
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
                                  margin: const EdgeInsets.only(bottom: 80),
                                  decoration: const BoxDecoration(
                                    //  boxShadow: boxShadow2,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        topRight: Radius.circular(25)),
                                    color: appPrimaryColor,
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 40, top: 40),
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
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14),
                                          ),
                                          20.widthXBox,
                                          AutoSizeText(
                                            'Delete account',
                                            style: TextStyles.montserrat
                                                .copyWith(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 14),
                                          ),
                                        ],
                                      ))))),
                    ],
                  );
                })));
  }

  void clearUserData() {
    Prefs.setString(Prefs.TOKEN, '');
    Prefs.setString(Prefs.FIRSTNAME, '');
  }

  void delete() {

    context.read<SettingsBloc>().add(DeleteUserEvent(token));
  }

  void cancel() {
    Navigator.pop(context);
  }
}
