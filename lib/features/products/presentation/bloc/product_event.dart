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

class GetProductTimesEvent extends ProductEvent {
  const GetProductTimesEvent(this.date, this.id);

  final String date;
  final int id;

  @override
  List<Object?> get props => [date, id];
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
  const SelectDate(this.date, this.productId, this.salonId);

  final DateTime date;
  final int productId;
  final String salonId;

  @override
  List<Object?> get props => [date, productId, salonId];
}

class SelectTime extends ProductEvent {
  const SelectTime(this.time, this.productId, this.salonId);

  final String time;
  final int productId;
  final String salonId;

  @override
  List<Object?> get props => [time, productId, salonId];
}

class RemoveReservation extends ProductEvent {
  const RemoveReservation();

  @override
  List<Object?> get props => [];
}
