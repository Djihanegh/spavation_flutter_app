import 'package:flutter/material.dart';

extension SizeBoxNumExtension on num {
  Widget get widthXBox => SizedBox(width: double.tryParse(toString()));

  Widget get heightXBox => SizedBox(height: double.tryParse(toString()));

  Widget get sizedBoxExt => SizedBox(
      height: double.tryParse(toString()), width: double.tryParse(toString()));
}
