import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:spavation/core/widgets/loading_widget.dart';
import '../../app/theme.dart';
import '../utils/app_styles.dart';
import '../utils/size_config.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {super.key,
      required this.title,
      required this.color,
      required this.textColor,
      this.borderColor,
      this.onPressed,
      required this.isLoading});

  final String title;
  final Color color;
  final Color textColor;
  final Color? borderColor;
  final Function? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => onPressed!(),
        child: Center(
            child: Container(
          width: sw! * 0.8,
          height: 50,
          padding: paddingAll(10),
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: borderColor ?? appFilterCoLOR)),
          child: isLoading
              ? const LoadingWidget()
              : AutoSizeText(
                  title,
                  style:
                      TextStyles.inter.copyWith(color: textColor, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
        )));
  }
}
