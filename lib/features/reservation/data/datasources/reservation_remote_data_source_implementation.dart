import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spavation/features/reservation/data/datasources/reservation_remote_data_source.dart';
import 'package:spavation/features/reservation/domain/entities/get_reservations_response.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/base_response.dart';
import '../../../../core/utils/constant.dart';
import '../../../../core/utils/endpoint.dart';

class ReservationsRemoteDataSrcImpl implements ReservationsRemoteDataSource {
  ReservationsRemoteDataSrcImpl(this._client);

  final http.Client _client;

  @override
  Future<GetReservationsResponse> getReservations({required String id}) async {
    try {
      final response = await _client.get(
        Uri.parse(Endpoints.baseUrl + Endpoints.reservations),
        headers: headersWithToken(id),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        BaseResponse result = BaseResponse.fromJson(jsonDecode(response.body));
        throw APIException(
            message: result.message, statusCode: response.statusCode);
      }

      return GetReservationsResponse.fromJson(jsonDecode(response.body));
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
