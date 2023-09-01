import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spavation/app/theme.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/features/home/presentation/widgets/custom_icon.dart';

import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/size_config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    screenSizeInit(context);
    return Scaffold(
        body: Stack(
      fit: StackFit.loose,
      children: [
        //
        Container(
          height: sh! * 0.25,
          decoration: BoxDecoration(
              boxShadow: boxShadow,
              color: appPrimaryColor,
              borderRadius: appBottomCircularRadius(30)),
        ),
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
            top: 50,
            left: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: Colors.white,
                ),
                AutoSizeText(
                  'Riyadh',
                  style: TextStyles.inter,
                ),
              ],
            )),

        Positioned(
            top: 50,
            right: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CustomIcon(icon: Icons.map_outlined),
                10.widthXBox,
                const CustomIcon(icon: Icons.filter_alt),
              ],
            ))
      ],
    ));
  }
}
