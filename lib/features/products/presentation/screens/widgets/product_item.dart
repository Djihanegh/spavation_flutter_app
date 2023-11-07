import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spavation/features/products/data/models/product_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../app/theme.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/utils/size_config.dart';
import '../../../../../../generated/assets.dart';
import '../../../../localization/domain/entities/language.dart';
import '../../../../localization/presentation/bloc/language_bloc.dart';
import '../../bloc/product_bloc.dart';
import 'showDialog.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({super.key, required this.product});

  final ProductModel product;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  ProductModel? product;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<LanguageBloc, LanguageState>(
        listener: (context, language) {},
        buildWhen: (prev, curr) =>
            prev.selectedLanguage != curr.selectedLanguage,
        builder: (context, language) {
          return BlocConsumer<ProductBloc, ProductState>(
              listener: (context, state) {},
              buildWhen: (prev, curr) =>
                  prev.selectedProducts != curr.selectedProducts,
              builder: (context, state) {
                if (state.selectedProducts != null) {
                  if (state.selectedProducts!.isNotEmpty) {
                    product = state.selectedProducts!.firstWhere(
                        (element) => element.id == widget.product.id,
                        orElse: () => ProductModel.empty());

                    if (product?.id == -1) {
                      product = null;
                    }
                  } else {
                    product = null;
                  }
                } else {
                  product = null;
                }
                return GestureDetector(
                    onTap: () {
                      product == null
                          ? showDateTimeDialog(
                              context: context,
                              product: widget.product,
                            )
                          : setState(() {
                              context
                                  .read<ProductBloc>()
                                  .add(RemoveProduct(widget.product));
                            });
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                            padding: language.selectedLanguage.value ==
                                    Language.english.value
                                ? EdgeInsets.only(
                                    left: sw! * 0.025, top: 20, bottom: 0)
                                : EdgeInsets.only(
                                    right: sw! * 0.038, top: 20, bottom: 0),
                            child: AutoSizeText(
                                l10n.localeName == 'en'
                                    ? widget.product.name
                                    : widget.product.nameAr,
                                style: TextStyles.inter
                                    .copyWith(color: red[2], fontSize: 15))),
                        Padding(
                            padding: language.selectedLanguage.value ==
                                    Language.english.value
                                ? EdgeInsets.only(left: sw! * 0.025, bottom: 0)
                                : EdgeInsets.only(right: sw! * 0.02, bottom: 0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      width: sw! * 0.75,
                                      child: AutoSizeText(
                                          widget.product.description,
                                          style: TextStyles.inter.copyWith(
                                              color: purple[0].withOpacity(0.8),
                                              fontSize: 12))),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      product == null
                                          ? GestureDetector(
                                              child: SvgPicture.asset(
                                                  Assets.iconsAddSvg,
                                                  height: 15))
                                          : GestureDetector(
                                              child: Icon(
                                              Icons.delete,
                                              color: red[0],
                                            )),
                                      AutoSizeText(
                                          '${widget.product.price} ${l10n.sr}',
                                          style: TextStyles.inter.copyWith(
                                              color: purple[3], fontSize: 15))
                                    ],
                                  ),
                                ]))
                      ],
                    ));
              });
        });
  }
}
