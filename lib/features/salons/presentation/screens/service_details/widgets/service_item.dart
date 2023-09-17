import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:spavation/features/home/presentation/screens/service_details/widgets/showDialog.dart';

import '../../../../../../app/theme.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/utils/size_config.dart';
import '../../../../../../generated/assets.dart';

class ServiceItem extends StatelessWidget {
  const ServiceItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(left: sw! * 0.038, top: 10, bottom: 0),
            child: AutoSizeText('Nails 1',
                style:
                    TextStyles.inter.copyWith(color: purple[2], fontSize: 15))),
        Padding(
            padding: EdgeInsets.only(left: sw! * 0.035, bottom: 0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                      width: sw! * 0.75,
                      child: AutoSizeText(
                          'This service includes many features \n that help complete completion',
                          style: TextStyles.inter
                              .copyWith(color: purple[2], fontSize: 15))),
                  Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(Assets.iconsAdd),
                          AutoSizeText('75 SR',
                              style: TextStyles.inter
                                  .copyWith(color: purple[3], fontSize: 15))
                        ],
                      ),
                ]))
      ],
    );
  }
}
