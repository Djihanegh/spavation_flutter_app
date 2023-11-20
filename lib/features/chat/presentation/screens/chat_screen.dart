import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/core/utils/navigation.dart';
import 'package:spavation/core/widgets/app_button.dart';
import 'package:spavation/features/chat/presentation/screens/widgets/chat_view.dart';
import '../../../../../../app/theme.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/utils/size_config.dart';
import '../../../../../../generated/assets.dart';
import '../../../../core/widgets/custom_back_button.dart';
import '../../../../localization.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    screenSizeInit(context);
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
        backgroundColor: appPrimaryColor,
        body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Stack(
                fit: StackFit.loose,
                alignment: Alignment.center,
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(
                                top: sh! * 0.05, left: 5, right: 20),
                            child: const Align(
                                alignment: Alignment.topLeft,
                                child: CustomBackButton())),
                        10.heightXBox,
                        Padding(
                            padding: EdgeInsets.only(
                                top: sh! * 0.2, left: 20, right: 20),
                            child: Container(
                                width: sw! * 0.96,
                                padding: paddingAll(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      20.heightXBox,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              child: Align(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  child: SvgPicture.asset(
                                                    Assets.iconsLogo,
                                                    colorFilter:
                                                        ColorFilter.mode(
                                                            purple[2],
                                                            BlendMode.srcIn),
                                                    height: 100,
                                                    width: 100,
                                                  ))),
                                        ],
                                      ),
                                      20.heightXBox,
                                      AutoSizeText(
                                        l10n.spavationLiveChat,
                                        style: TextStyles.inter.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                            color: purple[2]),
                                      ),
                                      AutoSizeText(
                                        l10n.liveChatWelcomeMessage,
                                        style: TextStyles.inter.copyWith(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15,
                                            color: Colors.black),
                                        textAlign: TextAlign.center,
                                      ),
                                      80.heightXBox,
                                      AppButton(
                                          title: l10n.startChat,
                                          color: purple[2],
                                          textColor: Colors.white,
                                          onPressed: () => navigateToPage(
                                              const ChatView(), context),
                                          isLoading: false),
                                      10.heightXBox,
                                    ]))),
                      ]),
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
                ])));
  }
}
