import 'package:dartz/dartz.dart';
import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/reservation/domain/repositories/reservation_repository.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/get_reservations_response.dart';
import '../datasources/reservation_remote_data_source.dart';

class ReservationRepositoryImplementation implements ReservationsRepository {
  final ReservationsRemoteDataSource _remoteDataSource;

  ReservationRepositoryImplementation(this._remoteDataSource);

  @override
  ResultFuture<GetReservationsResponse> getReservations(
      {required String id}) async {
    try {
      final result = await _remoteDataSource.getReservations(id: id);
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fomException(e));
    }
  }
}
