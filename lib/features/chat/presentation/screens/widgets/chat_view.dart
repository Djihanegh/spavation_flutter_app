import 'dart:convert';
import 'dart:developer';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:spavation/core/cache/cache.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/core/widgets/app_button.dart';
import 'package:spavation/core/widgets/app_snack_bar.dart';
import 'package:spavation/features/chat/presentation/screens/widgets/leave_chat_screen.dart';
import '../../../../../../app/theme.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/utils/size_config.dart';
import '../../../../../../generated/assets.dart';
import '../../../../../core/utils/navigation.dart';
import '../../../../../core/widgets/custom_back_button.dart';
import '../../../../../localization.dart';
import '../../../../home/presentation/screens/home/home_screen.dart';
import '../../../../settings/presentation/screens/update_user/widgets/custom_text_field.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart'
    as channels;
import 'package:http/http.dart' as http;
import '../../../data/models/messages.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key, required this.ticket});

  final int ticket;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late TextEditingController controller = TextEditingController();

  List<Messages> messages = [];
  final ScrollController _scrollController = ScrollController();
  final pusher = channels.PusherChannelsFlutter.getInstance();
  Channel? channel;
  int userId = -1;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getMessages();
    usePusher();
    userId = Prefs.getInt(Prefs.ID) ?? -1;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    log(messages.toString());

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
                                      messages.isEmpty
                                          ? Flexible(
                                              child: ListView.builder(
                                                  controller: _scrollController,
                                                  itemCount: 1,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return ListTile(
                                                        title: AutoSizeText(
                                                          l10n.spavationSupport,
                                                          style: TextStyles
                                                              .inter
                                                              .copyWith(
                                                                  color:
                                                                      purple[2],
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                        subtitle: AutoSizeText(
                                                          l10n.helloHowCanIhelpYou,
                                                          style: TextStyles
                                                              .inter
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                        ),
                                                        trailing: CircleAvatar(
                                                          backgroundColor:
                                                              purple[2],
                                                          radius: 20,
                                                          child:
                                                              SvgPicture.asset(
                                                            Assets.iconsLogo,
                                                            width: 30,
                                                            height: 30,
                                                          ),
                                                        ));
                                                  }))
                                          : Flexible(
                                              child: ListView.builder(
                                                controller: _scrollController,
                                                itemCount: messages.length,
                                                itemBuilder: (context, index) {
                                                  log(messages[index]
                                                      .userId
                                                      .toString());
                                                  return ListTile(
                                                    leading: messages[index]
                                                                        .userId ==
                                                                    "$userId" &&
                                                                l10n.localeName ==
                                                                    'ar' ||
                                                            messages[index]
                                                                        .userId !=
                                                                    "$userId" &&
                                                                l10n.localeName ==
                                                                    'en'
                                                        ? CircleAvatar(
                                                            child: Image.network(
                                                                messages[index]
                                                                    .userImage
                                                                    .toString(),
                                                                fit: BoxFit
                                                                    .fill),
                                                          )
                                                        : null,
                                                    trailing: messages[index]
                                                                        .userId !=
                                                                    "$userId" &&
                                                                l10n.localeName ==
                                                                    'ar' ||
                                                            messages[index]
                                                                        .userId ==
                                                                    "$userId" &&
                                                                l10n.localeName ==
                                                                    'en'
                                                        ? CircleAvatar(
                                                            child: Image.network(
                                                                messages[index]
                                                                    .userImage
                                                                    .toString(),
                                                                fit: BoxFit
                                                                    .fill),
                                                          )
                                                        : null,
                                                    title: AutoSizeText(
                                                        messages[index]
                                                            .userName,
                                                        style: TextStyles.inter
                                                            .copyWith(
                                                                color:
                                                                    purple[2],
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                        textDirection: messages[
                                                                        index]
                                                                    .userId ==
                                                                "$userId"
                                                            ? TextDirection.rtl
                                                            : TextDirection
                                                                .ltr),
                                                    subtitle: AutoSizeText(
                                                        messages[index].message,
                                                        style: TextStyles.inter
                                                            .copyWith(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                        textDirection: messages[
                                                                        index]
                                                                    .userId ==
                                                                "$userId"
                                                            ? TextDirection.rtl
                                                            : TextDirection
                                                                .ltr),
                                                  );
                                                },
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
                                          isLoading: _isLoading,
                                          color: purple[2],
                                          title: l10n.send,
                                          textColor: Colors.white,
                                          onPressed: () {
                                            if (controller.text.isNotEmpty) {
                                              if (!_isLoading) {
                                                setState(() {
                                                  _isLoading = true;
                                                });
                                                sendMessage();
                                              } else {
                                                openSnackBar(
                                                    context,
                                                    "Please wait..",
                                                    AnimatedSnackBarType
                                                        .warning);
                                              }
                                            } else {
                                              openSnackBar(
                                                  context,
                                                  "Message cannot be empty",
                                                  AnimatedSnackBarType.warning);
                                            }
                                          })),
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
                  Positioned(
                      top: sh! * 0.07,
                      left: l10n.localeName == 'en' ? null : 20,
                      right: l10n.localeName == 'en' ? 20 : null,
                      child: const CustomBackButton()),
                ])));
  }

  void getMessages() async {
    var request = http.Request('GET',
        Uri.parse('http://support.spavation.co/api/messages/${widget.ticket}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      setState(() {
        messages = messagesFromJson(data);
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      });
    } else {
      log(response.reasonPhrase.toString());
    }
  }

  //use pusher
  void usePusher() async {
    await pusher.init(apiKey: '06c899a1d674e5b85cb2', cluster: 'ap2');
    await pusher.subscribe(
        channelName: 'ticket.${widget.ticket}',
        onMemberAdded: (member) {
          log("Got member added event: $member");
        },
        onEvent: (event) {
          log("Got channel event: $event");
          setState(() {
            var data = jsonDecode(event.data!);

            messages.add(Messages(
                message: data['message'],
                userName: data['user_name'],
                userEmail: data['user_email'],
                userImage: data['user_image'],
                ticket: data['ticket'].toString(),
                userId: data['user_id'].toString()));

            setState(() {});

            log(messages.toString());
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            });
          });
        });
    await pusher.connect();
  }

  void sendMessage() async {
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse('http://support.spavation.co/api/send'));
    request.body = json
        .encode({"message": controller.text.toString(), "user_id": "$userId"});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      setState(() {
        controller.clear();
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  bool checkArabic(String msg) {
    if (RegExp(r'[\u0600-\u06FF]').hasMatch(msg.toString())) {
      return true;
    } else {
      return false;
    }
  }
}
