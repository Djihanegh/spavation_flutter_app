import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

openSnackBar(
    BuildContext context, String message, AnimatedSnackBarType type) async {
  return AnimatedSnackBar.material(message,
          duration: const Duration(seconds: 5),
          type: type,
          snackBarStrategy: RemoveSnackBarStrategy())
      .show(context);
}
