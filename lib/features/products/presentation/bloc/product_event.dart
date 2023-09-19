part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class GetProductsEvent extends ProductEvent {
  const GetProductsEvent(this.salonId);

  final String salonId;

  @override
  List<Object?> get props => [salonId];
}
