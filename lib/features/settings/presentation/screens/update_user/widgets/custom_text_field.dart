import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spavation/app/theme.dart';

import '../../../../../../core/utils/regex.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {Key? key,
      this.title,
      this.padding,
      this.controller,
      this.hintText,
      this.prefix,
      this.initialValue,
      this.obscureText,
      this.enabled,
      this.maxlines,
      this.icon,
      this.error,
      this.keyboardType,
      this.onChanged,
      required this.onSaved,
      this.suffixIcon,
      this.size,
      this.prefixIcon,
      this.validator})
      : super(key: key);

  final String? title;
  final double? padding;
  final double? size;

  final TextEditingController? controller;
  final String? hintText;
  final String? initialValue;
  final bool? obscureText;
  final bool? enabled;
  final String? error;
  final TextInputType? keyboardType;
  final Function? onChanged;
  final Function onSaved;
  final Widget? suffixIcon;
  final Widget? icon;
  final Widget? prefix;
  final int? maxlines;
  final Widget? prefixIcon;

  final Function? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
          top: padding ?? 10,
        ), // , left: 20, right: 20
        child: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                border: Border.all(color: Colors.white)),
            child: TextFormField(
              enabled: enabled,
              maxLines: maxlines ?? 1,
              controller: controller,
              obscureText: obscureText ?? false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onSaved: (newValue) => onSaved(newValue),
              onChanged: (value) => onChanged!(value),
              //  validator: (value) => validator!(value),
              onFieldSubmitted: (value) => onSaved(value),
              keyboardType: keyboardType,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(regexToRemoveEmoji))
              ],
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  focusColor: Colors.white,
                  prefixIconConstraints:
                      const BoxConstraints(minWidth: 23, maxHeight: 20),
                  isDense: true,
                  suffixIconConstraints: const BoxConstraints(
                    minWidth: 10,
                    minHeight: 10,
                  ),
                  contentPadding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  icon: icon,
                  prefix: prefix,
                  focusedErrorBorder: InputBorder.none,
                  errorStyle: const TextStyle(
                      color: Colors.transparent, fontSize: 0, height: 0),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: hintText,
                  labelStyle: GoogleFonts.montserrat(
                      color: Colors.white, fontSize: size ?? 18),
                  hintStyle: GoogleFonts.montserrat(
                      color: Colors.white, fontSize: size ?? 15),
                  suffixIcon: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: suffixIcon),
                  prefixIcon: Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      child: prefixIcon)),
            )));
  }
}
