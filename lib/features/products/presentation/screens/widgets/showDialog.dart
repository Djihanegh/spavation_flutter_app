import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spavation/core/utils/size_config.dart';
import 'package:spavation/features/products/data/models/product_model.dart';

import '../../bloc/product_bloc.dart';
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
            insetPadding: EdgeInsets.only(top: sh! * 0.35),
            scrollable: true,
            content: Container(
                width: sw! * 0.7,
                height: 320,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: DateTimeWidget(
                  product: product,
                )));
      }).then((value) async {
    // Check if the value returned from showDialog is null
    if (value == null) {
      if (context.read<ProductBloc>().state.selectedTime != null &&
          context.read<ProductBloc>().state.selectedDate != null) {
        context.read<ProductBloc>().add(SelectProduct(product));
      }
      print('Dialog closed by tapping outside');
    } else {
      // If value is not null, it means that the dialog was closed with a value
      // Print the value for debugging purposes
      print('Dialog closed with value: $value');
    }
  });
  ;
}
