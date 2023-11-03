import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:spavation/core/enum/enum.dart';
import 'package:spavation/core/utils/constant.dart';
import 'package:spavation/core/widgets/app_snack_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../app/theme.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../settings/presentation/screens/update_user/widgets/custom_text_field.dart';
import '../bloc/reservation_bloc.dart';

class DiscountCodeWidget extends StatefulWidget {
  const DiscountCodeWidget({super.key, required this.salonId});

  final String salonId;

  @override
  State<DiscountCodeWidget> createState() => _DiscountCodeWidgetState();
}

class _DiscountCodeWidgetState extends State<DiscountCodeWidget> {
  TextEditingController discountController = TextEditingController();
  bool? codeStatus;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<ReservationBloc, ReservationState>(
        listener: (context, state) {
          if (state.action == RequestType.checkCoupon) {
            if (state.status == FormzSubmissionStatus.failure) {
              openSnackBar(
                  context, state.errorMessage, AnimatedSnackBarType.error);

              setState(() {
                codeStatus = false;
              });
            }

            if (state.status == FormzSubmissionStatus.success) {
              setState(() {
                codeStatus = true;
              });
            }
          }
        },
        listenWhen: (prev, curr) => prev.status != curr.status,
        buildWhen: (prev, curr) => prev.status != curr.status,
        builder: (context, state) {
          return Column(
            children: [
              Container(
                  width: sw! * 0.95,
                  margin: paddingAll(10),
                  padding: paddingAll(10),
                  decoration: BoxDecoration(
                      boxShadow: boxShadow,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                      child: CustomTextFormField(
                    hintText: l10n.discountCode,
                    controller: discountController,
                    onSaved: () {
                      context
                          .read<ReservationBloc>()
                          .add(CheckCouponEvent('', discountController.text));
                    },
                    padding: 0,
                    suffixIcon: SizedBox(
                        width: 100,
                        child: AppButton(
                            color: appPrimaryColor,
                            title: l10n.apply,
                            textColor: Colors.white,
                            onPressed: () => checkCoupon())),
                  ))),
              codeStatus != null
                  ? codeStatus!
                      ? AutoSizeText(
                          state.successMessage,
                          style: TextStyles.inter
                              .copyWith(color: Colors.white, fontSize: 15),
                          textAlign: TextAlign.start,
                        )
                      : AutoSizeText(
                          state.errorMessage,
                          style: TextStyles.inter
                              .copyWith(color: red[0], fontSize: 15),
                          textAlign: TextAlign.start,
                        )
                  : emptyWidget()
            ],
          );
        });
  }

  void checkCoupon() {
    if (widget.salonId.isNotEmpty && discountController.text.isNotEmpty) {
      context
          .read<ReservationBloc>()
          .add(CheckCouponEvent(widget.salonId, discountController.text));
    }
  }
}
