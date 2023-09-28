import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/reservation/domain/entities/get_reservations_response.dart';
import '../repositories/reservation_repository.dart';
import 'package:spavation/core/usecase/usecase.dart';

class GetReservationsUseCase extends UseCaseWithParams<GetReservationsResponse, String> {
  const GetReservationsUseCase(this._repository);

  final ReservationsRepository _repository;

  @override
  ResultFuture<GetReservationsResponse> call(params) async =>
      _repository.getReservations(id: params);
}
