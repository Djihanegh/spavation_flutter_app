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
        listenWhen: (prev, curr) =>
            prev.selectedProducts != curr.selectedProducts,
        buildWhen: (prev, curr) =>
            prev.selectedProducts != curr.selectedProducts,
        builder: (context, state) {
          if (state.selectedProducts != null) {
            if (state.selectedProducts!.isNotEmpty) {
              product = state.selectedProducts!
                  .firstWhere((element) => element.id == widget.product.id);
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
                      EdgeInsets.only(left: sw! * 0.038, top: 10, bottom: 0),
                  child: AutoSizeText(widget.product.name,
                      style: TextStyles.inter
                          .copyWith(color: purple[2], fontSize: 15))),
              Padding(
                  padding: EdgeInsets.only(left: sw! * 0.035, bottom: 0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                            width: sw! * 0.75,
                            child: AutoSizeText(widget.product.description,
                                style: TextStyles.inter
                                    .copyWith(color: purple[2], fontSize: 15))),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            product == null
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        context
                                            .read<ProductBloc>()
                                            .add(SelectProduct(widget.product));
                                      });
                                      showDateTimeDialog(
                                          context: context,
                                          timeTo: widget.product.timeTo,
                                          timeFrom: widget.product.timeFrom,
                                          dateFrom: widget.product.dateFrom,
                                          dateTo: widget.product.dateTo);
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
