import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

//http
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart'
    as channels;
import 'package:pusher_client/pusher_client.dart';
import 'package:spavation/core/cache/cache.dart';
//import 'package:pusher_client/pusher_client.dart';

import 'contactUs.dart';
import 'messages.dart';

/*class ChatPage extends StatefulWidget {
  final String ticket;

  const ChatPage({super.key, required this.ticket});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Messages> messages = [];
  channels.PusherChannelsFlutter pusher =
      channels.PusherChannelsFlutter.getInstance();

  late PusherClient pusherClient;

  late Channel channel;

  TextEditingController mssg = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  var is_arabic = false;

  //get all messages
  void getMessages() async {
    var request = http.Request('GET',
        Uri.parse('http://support.spavation.co/api/messages/' + widget.ticket));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      setState(() {
        messages = messagesFromJson(data);

        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        });
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  closeChat() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('http://192.168.153.90:8000/api/closeChat'));
    request.body = json.encode({"user_id": 19});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      //go home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ContactUs()),
      );
    } else {
      print(response.reasonPhrase);
    }
  }

  void onConnectPressed() async {
    try {
      await pusher.init(
        apiKey: '06c899a1d674e5b85cb2',
        cluster: "ap2",
        onConnectionStateChange: onConnectionStateChange,
        onError: onError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEvent,
        onSubscriptionError: onSubscriptionError,
        onDecryptionFailure: onDecryptionFailure,
        onMemberAdded: onMemberAdded,
        onMemberRemoved: onMemberRemoved,
        onAuthorizer: onAuthorizer,

        // authEndpoint: "<Your Authendpoint Url>",
        // onAuthorizer: onAuthorizer
      );

      await pusher.subscribe(
          channelName: 'private-chat',
          onEvent: (event) {
            log("on chat Event $event");

            setState(() {
              var data = jsonDecode(event.data!);
              messages.add(Messages(
                  message: data['message'],
                  userName: data['user_name'],
                  userEmail: data['user_email'],
                  userImage: data['user_image']));
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _scrollController.animateTo(
                  _scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              });
            });
          });

      /*'chat', (event) {
              print(event!.data);
              //decode json

              setState(() {
                var data = jsonDecode(event.data!);
                messages.add(Messages(
                    message: data['message'],
                    userName: data['user_name'],
                    userEmail: data['user_email'],
                    userImage: data['user_image']));
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                });
              });
            });*/
      await pusher.connect();
    } catch (e) {
      log("ERROR: $e");
    }
  }

  getSignature(String value) {
    var key = utf8.encode('06c899a1d674e5b85cb2');
    var bytes = utf8.encode(value);

    var hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
    var digest = hmacSha256.convert(bytes);
    print("HMAC signature in string is: $digest");
    return digest;
  }

  dynamic onAuthorizer(
      String channelName, String socketId, dynamic options) async {
    return {
      "auth": "06c899a1d674e5b85cb2:${getSignature("${widget.ticket}:chat")}",
    };
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    log("Connection: $currentState");
  }

  void onError(String message, int? code, dynamic e) {
    log("onError: $message code: $code exception: $e");
  }

  void onEvent(channels.PusherEvent event) {
    log("onEvent: $event");
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    log("onSubscriptionSucceeded: $channelName data: $data");
    final me = pusher.getChannel(channelName)?.me;
    log("Me: $me");
  }

  void onSubscriptionError(String message, dynamic e) {
    log("onSubscriptionError: $message Exception: $e");
  }

  void onDecryptionFailure(String event, String reason) {
    log("onDecryptionFailure: $event reason: $reason");
  }

  void onMemberAdded(String channelName, channels.PusherMember member) {
    log("onMemberAdded: $channelName user: $member");
  }

  void onMemberRemoved(String channelName, channels.PusherMember member) {
    log("onMemberRemoved: $channelName user: $member");
  }

  void onTriggerEventPressed() async {
    final channel = pusher.getChannel('private-chat');
    // Bind to the 'new-message' event

    try {
      if (channel != null) {
        channel.trigger(channels.PusherEvent(
            channelName: 'private-chat',
            eventName: 'client-receiving-chat',
            userId: "19",
            data: mssg.text));
      } else {
        log('NULLL');
      }
    } catch (e) {
      log(e.toString());
    }

    /* {
            "message": mssg.text.toString(),
            "user_id": "19",
            "user_image": "dsjdjsndk",
            "user_name": "DJIHANE",
            "user_email": "djihaneghilani@gmail.com"
          }



           pusher.trigger(PusherEvent(
        channelName: 'ticket.${widget.ticket}',
        eventName: 'chat',
        data: {
          "message": mssg.text,
          "user_id": "19",
          "user_image": "",
          "user_name": "DJIHANE",
          "user_email": "email"
        }));*/
  }

  @override
  void initState() {
    super.initState();
    getMessages();
    // onConnectPressed();

    pusherClient = PusherClient(
      "06c899a1d674e5b85cb2",
       PusherOptions(
        // if local on android use
        host: '10.0.2.2',
        encrypted: false,
        cluster: 'ap2',
      ),
      enableLogging: false,
    );
    // Subscribe to the chat channel
    channel = pusherClient.subscribe('ticket.${widget.ticket}');


    // Bind to the 'new-message' event
     channel.bind('chat', (event) {
      log(event!.data.toString());
      //decode json

      setState(() {
        var data = jsonDecode(event.data!);
        messages.add(Messages(
            message: data['message'],
            userName: data['user_name'],
            userEmail: data['user_email'],
            userImage: data['user_image']));
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        });
      });
    });

    pusherClient.connect();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('Chat Page'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  //close chat api call
                  closeChat();
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.red,
                  size: 30,
                )),
          )
        ],
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Image.network(messages[index].userImage.toString(),
                        fit: BoxFit.fill),
                  ),
                  title: Text(messages[index].message,
                      style: const TextStyle(
                        fontSize: 20.0,
                        // change this to your desired font size
                        fontWeight: FontWeight.bold,
                        // change this to your desired font weight
                        color: Colors.blue, // change this to your desired color
                      ),
                      textDirection: checkArabic(messages[index].message)
                          ? TextDirection.rtl
                          : TextDirection.ltr),
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  bool checkArabic(String msg) {
    if (RegExp(r'[\u0600-\u06FF]').hasMatch(msg.toString())) {
      return true;
    } else {
      return false;
    }
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (value) {
                if (RegExp(r'[\u0600-\u06FF]').hasMatch(mssg.text.toString())) {
                  setState(() {
                    is_arabic = true;
                  });
                } else {
                  setState(() {
                    is_arabic = false;
                  });
                }
              },
              controller: mssg,
              textDirection: is_arabic ? TextDirection.rtl : TextDirection.ltr,
              decoration: InputDecoration(
                hintText: "Type a message",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            color: Colors.blue,
            onPressed: () async {
              // Send the message and trigger a 'new-message' event
              // You'll need to implement the server-side logic to handle this event
              // Assuming 'YOUR_CHANNEL_ID' is the channel you want to send the message to
              var headers = {'Content-Type': 'application/json'};
              var request = http.Request(
                  'POST', Uri.parse('http://support.spavation.co/api/send'));
              request.body = json
                  .encode({"message": mssg.text.toString(), "user_id": "19"});
              request.headers.addAll(headers);

              http.StreamedResponse response = await request.send();

              if (response.statusCode == 200) {
                print(await response.stream.bytesToString());
                //  onTriggerEventPressed();
                setState(() {
                  mssg.clear();
                });
              } else {
                print(await response.stream.bytesToString());
              }
            },
          ),
        ],
      ),
    );
  }
}
*/

class ChatPage extends StatefulWidget {
  final String ticket;

  const ChatPage({super.key, required this.ticket});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Messages> messages = [];

  //  PusherClient? pusher;
  Channel? channel;
  TextEditingController mssg = new TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final pusher = channels.PusherChannelsFlutter.getInstance();
  var is_arabic = false;

  //get all messages
  void getMessages() async {
    var request = http.Request('GET',
        Uri.parse('http://support.spavation.co/api/messages/' + widget.ticket));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      setState(() {
        messages = messagesFromJson(data);
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  closeChat() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('http://support.spavation.co/api/closeChat'));
    request.body = json.encode({"user_id": 19});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      //go home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ContactUs()),
      );
    } else {
      print(response.reasonPhrase);
    }
  }

  //use pusher
  void usePusher() async {
    await pusher.init(apiKey: '06c899a1d674e5b85cb2', cluster: 'ap2');
    await pusher.subscribe(
        channelName: 'ticket.${widget.ticket}',
        onMemberAdded: (member) {
          print("Got member added event: $member");
        },
        onEvent: (event) {
          print("Got channel event: $event");
          setState(() {
            var data = jsonDecode(event.data!);
            messages.add(Messages(
                message: data['message'],
                userName: data['user_name'],
                userEmail: data['user_email'],
                userImage: data['user_image']));
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            });
          });
        });
    await pusher.connect();
  }

  @override
  void initState() {
    super.initState();
    getMessages();
    usePusher();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Chat Page'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  //close chat api call
                  closeChat();
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.red,
                  size: 30,
                )),
          )
        ],
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Image.network(messages[index].userImage.toString(),
                        fit: BoxFit.fill),
                  ),
                  title: Text(messages[index].message,
                      style: TextStyle(
                        fontSize: 20.0,
                        // change this to your desired font size
                        fontWeight: FontWeight.bold,
                        // change this to your desired font weight
                        color: Colors.blue, // change this to your desired color
                      ),
                      textDirection: checkArabic(messages[index].message)
                          ? TextDirection.rtl
                          : TextDirection.ltr),
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  bool checkArabic(String msg) {
    if (RegExp(r'[\u0600-\u06FF]').hasMatch(msg.toString())) {
      return true;
    } else {
      return false;
    }
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (value) {
                if (RegExp(r'[\u0600-\u06FF]').hasMatch(mssg.text.toString())) {
                  setState(() {
                    is_arabic = true;
                  });
                } else {
                  setState(() {
                    is_arabic = false;
                  });
                }
              },
              controller: mssg,
              textDirection: is_arabic ? TextDirection.rtl : TextDirection.ltr,
              decoration: InputDecoration(
                hintText: "Type a message",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            color: Colors.blue,
            onPressed: () async {
              // Send the message and trigger a 'new-message' event
              // You'll need to implement the server-side logic to handle this event
              // Assuming 'YOUR_CHANNEL_ID' is the channel you want to send the message to
              var headers = {'Content-Type': 'application/json'};
              var request = http.Request(
                  'POST', Uri.parse('http://support.spavation.co/api/send'));
              request.body = json
                  .encode({"message": mssg.text.toString(), "user_id": "19"});
              request.headers.addAll(headers);

              http.StreamedResponse response = await request.send();

              if (response.statusCode == 200) {
                print(await response.stream.bytesToString());
                setState(() {
                  mssg.clear();
                });
              } else {
                print(await response.stream.bytesToString());
              }
            },
          ),
        ],
      ),
    );
  }
}
