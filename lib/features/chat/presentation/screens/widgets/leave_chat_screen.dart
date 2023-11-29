import 'dart:convert';
import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/core/widgets/app_button.dart';
import 'package:spavation/core/widgets/loading_widget.dart';
import 'package:spavation/features/home/presentation/screens/home/home_screen.dart';
import '../../../../../../app/theme.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/utils/size_config.dart';
import '../../../../../../generated/assets.dart';
import '../../../../../core/cache/cache.dart';
import '../../../../../core/utils/navigation.dart';
import '../../../../../core/widgets/custom_back_button.dart';
import '../../../../../localization.dart';
import 'package:http/http.dart' as http;

class LeaveChatScreen extends StatefulWidget {
  const LeaveChatScreen({super.key});

  @override
  State<LeaveChatScreen> createState() => _LeaveChatScreenState();
}

class _LeaveChatScreenState extends State<LeaveChatScreen> {
  late TextEditingController controller = TextEditingController();

  int userId = -1;

  @override
  void initState() {
    userId = Prefs.getInt(Prefs.ID) ?? -1;
    super.initState();
  }

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
                        10.heightXBox,
                        Padding(
                          padding: EdgeInsets.only(
                              top: sh! * 0.25, left: 20, right: 20),
                          child: Container(
                              width: sw! * 0.96,
                              height: sh! * 0.45,
                              padding: paddingAll(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: sh! * 0.08,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            child: Align(
                                                alignment: Alignment.topCenter,
                                                child: SvgPicture.asset(
                                                  Assets.iconsLogo,
                                                  colorFilter: ColorFilter.mode(
                                                      purple[2],
                                                      BlendMode.srcIn),
                                                  height: 100,
                                                  width: 100,
                                                ))),
                                      ],
                                    ),
                                    20.heightXBox,
                                    Directionality(
                                        textDirection: TextDirection.ltr,
                                        child: AutoSizeText(
                                          l10n.spavationLiveChat,
                                          style: TextStyles.inter.copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25,
                                              color: purple[2]),
                                        )),
                                    AutoSizeText(
                                      l10n.leaveConversationText,
                                      style: TextStyles.inter.copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                          color: Colors.black),
                                      textAlign: TextAlign.center,
                                    ),
                                    20.heightXBox,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                            width: 100,
                                            child: AppButton(
                                                borderColor: Colors.black,
                                                title: l10n.stay,
                                                color: purple[2],
                                                textColor: Colors.white,
                                                onPressed: () => {pop(context)},
                                                isLoading: false)),
                                        20.widthXBox,
                                        SizedBox(
                                            width: 100,
                                            child: AppButton(
                                                borderColor: dividerColor,
                                                title: l10n.end,
                                                color: Colors.white,
                                                textColor: red[0],
                                                onPressed: () => closeChat(),
                                                isLoading: false)),
                                        20.heightXBox,
                                        if (_isLoading) const LoadingWidget()
                                      ],
                                    )
                                  ])),
                        ),
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
                  Positioned(
                      top: sh! * 0.07,
                      left: l10n.localeName == 'en' ? null : 20,
                      right: l10n.localeName == 'en' ? 20 : null,
                      child: const CustomBackButton()),
                ])));
  }

  bool _isLoading = false;

  closeChat() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('http://support.spavation.co/api/closeChat'));
    request.body = jsonEncode({"user_id": userId});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 50));

    if (response.statusCode == 200) {
      setState(() {
        _isLoading = false;
      });
      //go home
      if (context.mounted) {
        navigateAndRemoveUntil(const HomeScreen(), context, false);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      log(response.reasonPhrase.toString());
    }
  }
}
