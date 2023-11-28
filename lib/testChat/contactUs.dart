import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

//http
import 'package:http/http.dart' as http;

import 'ChatPage.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  var ticket = 0;

  //check chat || create new
  checkChat() async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request(
          'POST', Uri.parse('http://support.spavation.co/api/checkChat'));
      request.body = json.encode({
        "user_id": 19 //userId
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        //decode
        var data = jsonDecode(await response.stream.bytesToString());
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChatPage(
                    ticket: data['ticket'].toString(),
                  )),
        );
      } else {
        log(response.reasonPhrase.toString());
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Contact Us'),
          backgroundColor: Colors.blueGrey,
        ),
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: 200,
                    height: 55,
                    child: ElevatedButton(
                        onPressed: () {
                          checkChat();
                        },
                        child: Text('Live Chat'))),
              ),
            ],
          ),
        ));
  }
}
