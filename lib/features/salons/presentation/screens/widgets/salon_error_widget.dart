import 'package:flutter/material.dart';

import '../../../../../core/utils/size_config.dart';

class SalonErrorWidget extends StatelessWidget {
  const SalonErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: SizedBox(
            width: sw! * 0.99,
            height: sh! * 0.15,
            child: const Icon(Icons.error, color: Colors.black)));
  }
}
