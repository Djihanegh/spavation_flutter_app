import 'package:dartz/dartz.dart';
import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/reservation/domain/entities/add_reservation_response.dart';
import 'package:spavation/features/reservation/domain/entities/check_coupon_response.dart';
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

  @override
  ResultFuture<CheckCouponResponse> checkCoupon(
      {required String salonId, required String code}) async {
    try {
      final result =
          await _remoteDataSource.checkCoupon(code: code, salonId: salonId);
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fomException(e));
    }
  }

  @override
  ResultFuture<AddReservationResponse> addReservation(
      {required DataMap data}) async {
    try {
      final result = await _remoteDataSource.addReservation(data: data);
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fomException(e));
    }
  }
}
