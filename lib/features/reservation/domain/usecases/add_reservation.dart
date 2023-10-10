import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/reservation/domain/entities/add_reservation_response.dart';
import '../repositories/reservation_repository.dart';
import 'package:spavation/core/usecase/usecase.dart';

class AddReservationUseCase
    extends UseCaseWithParams<AddReservationResponse, DataMap> {
  const AddReservationUseCase(this._repository);

  final ReservationsRepository _repository;

  @override
  ResultFuture<AddReservationResponse> call(params) async =>
      _repository.addReservation(data: params);
}
