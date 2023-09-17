import 'package:flutter/material.dart';

import '../../../../../core/utils/size_config.dart';

class BannerErrorWidget extends StatelessWidget {
  const BannerErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: sh! * 0.125,
        right: sw! * 0.01,
        child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: SizedBox(
                width: sw! * 0.99,
                height: sh! * 0.15,
                child: const Icon(Icons.error, color: Colors.black))));
  }
}
