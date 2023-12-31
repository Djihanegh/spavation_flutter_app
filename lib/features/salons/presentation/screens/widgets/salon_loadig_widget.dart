import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/utils/size_config.dart';

class SalonShimmer extends StatelessWidget {
  const SalonShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenSizeInit(context);

    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Center(
            child: Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          width: sw! * 0.97,
          height: sh! * 0.15,
          child: Shimmer.fromColors(
              baseColor: const Color(0XFFC2C2C2), //Colors.grey[400]!,
              highlightColor: const Color(0XFFC2C2C2), //Colors.grey[100]!,
              child: _body()),
        )));
  }

  Widget _body() {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Container(
            width: sw! * 0.97,
            height: sh! * 0.15,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            )));
  }
}
