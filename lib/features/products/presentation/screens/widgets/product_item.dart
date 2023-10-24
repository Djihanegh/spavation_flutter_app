import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spavation/features/products/data/models/product_model.dart';

import '../../../../../../app/theme.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/utils/size_config.dart';
import '../../../../../../generated/assets.dart';
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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding:
                      EdgeInsets.only(left: sw! * 0.038, top: 20, bottom: 0),
                  child: AutoSizeText(widget.product.name,
                      style: TextStyles.inter
                          .copyWith(color: purple[2], fontSize: 15))),
              Padding(
                  padding: EdgeInsets.only(left: sw! * 0.035, bottom: 0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: sw! * 0.75,
                            child: AutoSizeText(widget.product.description,
                                style: TextStyles.inter
                                    .copyWith(color: purple[2].withOpacity(0.8), fontSize: 12))),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            product == null
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {});
                                      showDateTimeDialog(
                                        context: context,
                                        product: widget.product,
                                      );
                                    },
                                    child: Image.asset(Assets.iconsAdd))
                                : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        context
                                            .read<ProductBloc>()
                                            .add(RemoveProduct(widget.product));
                                      });
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: red[0],
                                    )),
                            AutoSizeText('${widget.product.price} SR',
                                style: TextStyles.inter
                                    .copyWith(color: purple[3], fontSize: 15))
                          ],
                        ),
                      ]))
            ],
          );
        });
  }
}
