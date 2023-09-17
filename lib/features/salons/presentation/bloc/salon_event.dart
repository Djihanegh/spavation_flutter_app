part of 'salon_bloc.dart';

abstract class SalonEvent extends Equatable {
  const SalonEvent();
}

class GetSalonsEvent extends SalonEvent {
  const GetSalonsEvent();

  @override
  List<Object?> get props => [];
}
