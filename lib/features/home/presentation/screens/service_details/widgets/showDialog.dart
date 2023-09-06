import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spavation/core/utils/size_config.dart';
import 'package:spavation/features/home/presentation/screens/service_details/widgets/date_time_widget.dart';
import 'package:spavation/generated/assets.dart';

import '../../../../../../app/theme.dart';
import '../../../../../../core/utils/app_styles.dart';

showDateTimeDialog({
  required BuildContext context,
}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            backgroundColor: Colors.white,
            shadowColor: Colors.white,
            surfaceTintColor: Colors.white,
            insetPadding: EdgeInsets.only(top: sh! * 0.35),
            scrollable: true,
            content: Container(
                width: sw! * 0.7,
                height: sh! * 0.38,
                // padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: const DateTimeWidget()

                /* RepaintBoundary(
                              key: globalKey,
                              child: QrImage(
                                  data: eventCode,
                                  padding: const EdgeInsets.all(20),
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black)),*/

                ));
      });
}
