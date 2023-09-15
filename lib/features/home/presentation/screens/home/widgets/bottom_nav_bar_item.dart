import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spavation/app/theme.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class BottomNavBarItem extends StatelessWidget {
  const BottomNavBarItem({super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
    required this.index,
    required this.navBarIndex});

  final String icon;
  final String title;
  final Function onPressed;
  final int index;
  final int navBarIndex;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          SvgPicture.asset(
          icon,
          colorFilter: ColorFilter.mode(
              index == navBarIndex ? appPrimaryColor : Colors.white,
              BlendMode.srcIn),

      height: 25,
      width: 25,
    ),
    5.heightXBox,
    AutoSizeText(
    title,
    style: TextStyles.inter.copyWith(
    color: index == navBarIndex ? appPrimaryColor : Colors.white,
    fontSize: 10),
    textAlign: TextAlign.center,
    )
    ]
    ,
    )
    );
  }
}
