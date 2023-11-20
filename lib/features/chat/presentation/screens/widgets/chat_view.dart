import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/core/widgets/app_button.dart';
import 'package:spavation/features/chat/presentation/screens/widgets/leave_chat_screen.dart';
import '../../../../../../app/theme.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/utils/size_config.dart';
import '../../../../../../generated/assets.dart';
import '../../../../../core/utils/navigation.dart';
import '../../../../../core/widgets/custom_back_button.dart';
import '../../../../../localization.dart';
import '../../../../settings/presentation/screens/update_user/widgets/custom_text_field.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    screenSizeInit(context);
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
                          child: Stack(children: [
                            Container(
                                width: sw! * 0.96,
                                height: sh! * 0.45,
                                padding: paddingAll(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: sh! * 0.08,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: '',
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: l10n.youAreChattingWith,
                                                style: TextStyles.inter
                                                    .copyWith(
                                                        color: Colors.black,
                                                        fontSize: 15)),
                                            TextSpan(
                                                text: l10n.supportTeam,
                                                style: TextStyles.inter
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                        color: Colors.black)),
                                          ],
                                        ),
                                      ),
                                      10.heightXBox,
                                      ListTile(
                                        title: AutoSizeText(
                                          l10n.spavationSupport,
                                          style: TextStyles.inter.copyWith(
                                              color: purple[2],
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: AutoSizeText(
                                          l10n.helloHowCanIhelpYou,
                                          style: TextStyles.inter.copyWith(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        trailing: CircleAvatar(
                                          backgroundColor: purple[2],
                                          radius: 20,
                                          child: SvgPicture.asset(
                                            Assets.iconsLogo,
                                            width: 30,
                                            height: 30,
                                          ),
                                        ),
                                      ),
                                      10.heightXBox,
                                    ])),
                            Container(
                                width: sw! * 0.96,
                                padding: paddingAll(15),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                        onTap: () => navigateToPage(
                                            const LeaveChatScreen(), context),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: Image.asset(Assets.iconsFrame),
                                        )),
                                    AutoSizeText(
                                      l10n.liveSupportChat,
                                      style: TextStyles.inter.copyWith(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  ],
                                ))
                          ]),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 20, right: 20),
                            child: Container(
                                width: sw! * 0.95,
                                padding: paddingAll(10),
                                decoration: BoxDecoration(
                                    boxShadow: boxShadow,
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15)),
                                child: CustomTextFormField(
                                  hintText: l10n.typeYourMessage,
                                  controller: controller,
                                  onSaved: (e) {},
                                  onChanged: (e) {},
                                  padding: 0,
                                  prefixIcon: SizedBox(
                                      width: 100,
                                      child: AppButton(
                                          isLoading: false,
                                          color: purple[2],
                                          title: l10n.send,
                                          textColor: Colors.white,
                                          onPressed: () => {})),
                                ))),
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
