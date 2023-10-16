part of 'salon_bloc.dart';

abstract class SalonEvent extends Equatable {
  const SalonEvent();
}

class GetSalonsEvent extends SalonEvent {
  const GetSalonsEvent();

  @override
  List<Object?> get props => [];
}

class GetSalonsByCategoryEvent extends SalonEvent {
  const GetSalonsByCategoryEvent(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}
