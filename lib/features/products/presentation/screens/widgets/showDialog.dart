import 'package:flutter/material.dart';
import 'package:spavation/core/utils/size_config.dart';
import 'package:spavation/features/products/data/models/product_model.dart';

import 'date_time_widget.dart';

showDateTimeDialog({
  required BuildContext context,
  required ProductModel product,
}) {
  showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                backgroundColor: Colors.white,
                shadowColor: Colors.white,
                surfaceTintColor: Colors.white,
                insetPadding: EdgeInsets.only(top: sh! * 0.05),
                scrollable: true,
                content: Container(
                    width: sw! * 0.7,
                    height: 500,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: DateTimeWidget(
                      product: product,
                    )));
          })
      ;
}
