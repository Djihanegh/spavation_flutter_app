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

class SelectProduct extends ProductEvent {
  const SelectProduct(this.product);

  final ProductModel product;

  @override
  List<Object?> get props => [product];
}

class RemoveProduct extends ProductEvent {
  const RemoveProduct(this.product);

  final ProductModel product;

  @override
  List<Object?> get props => [product];
}

class SelectDate extends ProductEvent {
  const SelectDate(this.date);

  final DateTime date;

  @override
  List<Object?> get props => [date];
}

class SelectTime extends ProductEvent {
  const SelectTime(this.time);

  final String time;

  @override
  List<Object?> get props => [time];
}
