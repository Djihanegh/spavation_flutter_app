import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:spavation/features/reservation/presentation/widgets/status_button.dart';

import '../../../../app/theme.dart';
import '../../../../core/utils/app_styles.dart';

class ReservationItem extends StatelessWidget {
  const ReservationItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.white,
          radius: 30,
        ),
        title: AutoSizeText(
          'Woman SPA',
          style: TextStyles.inter.copyWith(
              color: whiteWithOpacity,
              fontWeight: FontWeight.w700,
              fontSize: 16),
        ),
        subtitle: AutoSizeText(
          'Woman SPA',
          style:
              TextStyles.inter.copyWith(color: whiteWithOpacity, fontSize: 14),
        ),
        trailing: const StatusButton(
          status: false,
        ));
  }
}
