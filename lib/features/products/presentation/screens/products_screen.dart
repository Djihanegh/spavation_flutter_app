import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spavation/core/widgets/loading_widget.dart';
import 'package:spavation/features/products/presentation/screens/widgets/products_view.dart';
import '../../../../app/theme.dart';
import '../../../../core/utils/constant.dart';
import '../../../../core/utils/size_config.dart';
import '../../../reservation/presentation/bloc/reservation_bloc.dart';
import '../../../../core/widgets/error_widget.dart';
import '../bloc/product_bloc.dart';
import 'widgets/product_loading_widget.dart';
import 'widgets/products_empty_widget.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen(
      {super.key,
      required this.salonId,
      required this.isForMale,
      required this.isForFemale,
      required this.distance,
      required this.name,
      required this.description,
      required this.image,
      required this.taxRate,
      required this.closeTime,
      required this.taxNumber,
      required this.rate});

  final String salonId;
  final int isForMale;
  final int isForFemale;
  final String distance;
  final String name;
  final String description;
  final String image;
  final String taxRate;
  final String taxNumber;
  final String closeTime;
  final int rate;

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late ProductBloc _productBloc;

  bool firstRun = false;

  @override
  void initState() {
    _productBloc = BlocProvider.of(context);
    _productBloc.add(const RemoveReservation());
    _productBloc.add(GetProductsEvent(widget.salonId, 'atsalon'));
    firstRun = true;
    context.read<ReservationBloc>().add(const InitializeDiscount());
    super.initState();
  }

  void _refresh() {
    _productBloc.add(GetProductsEvent(widget.salonId, 'atsalon'));
  }

  @override
  Widget build(BuildContext context) {
    screenSizeInit(context);
    return Scaffold(
        backgroundColor: appPrimaryColor,
        body: SingleChildScrollView(
            child: BlocConsumer<ProductBloc, ProductState>(
                listener: (context, state) {},
                listenWhen: (prev, curr) =>
                    prev.reservations != curr.reservations,
                buildWhen: (prev, curr) =>
                    prev.reservations != curr.reservations ||
                    prev.selectedProducts != curr.selectedProducts ||
                    prev.status != curr.status && firstRun,
                builder: (context, state) {
                  Widget? child;
                  Widget? subChild;

                  child = body(subChild);

                  if (state.status == ProductStatus.inProgress ||
                      state.status == ProductStatus.initial) {
                    subChild = const ProductLoadingWidget();
                  }
                  if (state.status == ProductStatus.failure) {
                    subChild = CustomErrorWidget(
                      onRefresh: () => _refresh(),
                      errorMessage: state.errorMessage,
                    );
                  }

                  if (state.status == ProductStatus.success) {
                    firstRun = false;
                    if (state.data == [] || state.data == null) {
                      subChild = const ProductsEmptyWidget();
                    } else {
                      ///// NEED TO BE REFACTORED
                      subChild = ProductsView(
                        name: widget.name,
                        rate: widget.rate,
                        description: widget.description,
                        image: widget.image,
                        taxRate: widget.taxRate,
                        taxNumber: widget.taxNumber,
                        salonId: widget.salonId,
                        isForMale: widget.isForMale,
                        isForFemale: widget.isForFemale,
                        distance: widget.distance,
                        closeTime: widget.closeTime,
                      );
                    }
                  }

                  if (subChild != null) {
                    child = body(subChild);
                  }

                  return child;
                })));
  }

  Widget body(Widget? subChild) {
    return Center(
        child: Stack(alignment: Alignment.center, children: [
      Padding(
          padding: EdgeInsets.only(
              top: subChild is LoadingWidget ? sh! * 0.2 : sh! * 0.15),
          child: subChild ?? emptyWidget()),
      Positioned(
          top: -10,
          left: -25,
          child: Container(
            height: sh! * 0.17,
            width: sw! * 0.35,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.35),
                borderRadius: appCircular),
          )),
    ]));
  }
}
