import 'package:flutter/material.dart';

import '../../../../../app/theme.dart';
import '../../../../../core/utils/size_config.dart';
import '../../../../../core/widgets/custom_back_button.dart';

class ServiceDetailsScreen extends StatefulWidget {
  const ServiceDetailsScreen({super.key});

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    screenSizeInit(context);
    return Scaffold(
        backgroundColor: appPrimaryColor,
        body: Center(
            child: Stack(alignment: Alignment.center, children: [
          Padding(
              padding: EdgeInsets.only(top: sh! * 0.3),
              child: const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomBackButton(),
                      ],
                    )
                  ])),
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
