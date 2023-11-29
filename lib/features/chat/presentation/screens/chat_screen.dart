import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spavation/core/cache/cache.dart';
import 'package:spavation/core/errors/api_message_handler.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/core/utils/navigation.dart';
import 'package:spavation/core/widgets/app_button.dart';
import 'package:spavation/core/widgets/app_snack_bar.dart';
import '../../../../../../app/theme.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/utils/size_config.dart';
import '../../../../../../generated/assets.dart';
import '../../../../core/widgets/custom_back_button.dart';
import '../../../../localization.dart';

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../../../localization/domain/entities/language.dart';
import '../../../localization/presentation/bloc/language_bloc.dart';
import 'widgets/chat_view.dart';

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
    log('REBUILD');
    log(l10n.localeName);

    return Scaffold(
        backgroundColor: appPrimaryColor,
        body: Stack(
            fit: StackFit.loose,
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    /*  GestureDetector(
                          onTap: () {
                            log('SALAMMMM');
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: Center(
                              child: Icon(
                                Icons.navigate_next,
                                color: appPrimaryColor,
                                size: 20,
                              ),
                              /* onPressed: () {
                        log('ICON PRESSED');
                        pop(context);
                      },*/
                            ),
                          ),
                        ), */
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  20.heightXBox,
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
                                                    purple[2], BlendMode.srcIn),
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
                                  AutoSizeText("Spavation",
                                      style: TextStyles.inter.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          color: purple[2])),
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
                                      onPressed: () => checkChat(),
                                      isLoading: _isLoading),
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
              Positioned(
                  top: sh! * 0.07,
                  left: l10n.localeName == 'en' ? null : 0,
                  right: l10n.localeName == 'en' ? 10 : null,
                  child: const CustomBackButton()),
            ]));
  }

  /*GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        log('PRESSED 22222');
                        pop(context);
                      },
                      child: const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white, // width: 30,
                        /* decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),*/
                        child: Center(
                          child: Icon(
                            Icons.navigate_next,
                            color: appPrimaryColor,
                            size: 20,
                          ),
                        ),
                      ))*/

  bool _isLoading = false;

  checkChat() async {
    http.StreamedResponse? response;
    try {
      int userId = Prefs.getInt(Prefs.ID) ?? -1;
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request(
          'POST', Uri.parse('http://support.spavation.co/api/checkChat'));
      request.body = json.encode({
        "user_id": userId //userId
      });
      request.headers.addAll(headers);

      response = await request.send();

      setState(() {
        _isLoading = true;
      });
      await Future.delayed(const Duration(milliseconds: 50));

      if (response.statusCode == 200) {
        setState(() {
          _isLoading = false;
        });
        //decode
        var data = jsonDecode(await response.stream.bytesToString());
        if (context.mounted) {
          navigateToPage(
              ChatView(
                ticket: data['ticket'],
              ),
              context);
        }

        //http
      } else {
        setState(() {
          _isLoading = false;
        });
        log(response.reasonPhrase.toString());
        if (context.mounted) {
          setState(() {
            openSnackBar(context, response!.reasonPhrase.toString(),
                AnimatedSnackBarType.error);
          });
        }
      }
    } catch (e) {
      log(e.toString());
      if (context.mounted) {
        setState(() {
          openSnackBar(context, catchStreamedExceptions(response, e),
              AnimatedSnackBarType.error);
        });
      }
    }
  }
}
