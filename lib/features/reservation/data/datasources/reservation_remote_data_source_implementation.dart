import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:spavation/core/cache/cache.dart';
import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/reservation/data/datasources/reservation_remote_data_source.dart';
import 'package:spavation/features/reservation/domain/entities/add_reservation_response.dart';
import 'package:spavation/features/reservation/domain/entities/check_coupon_response.dart';
import 'package:spavation/features/reservation/domain/entities/get_reservations_response.dart';
import '../../../../core/errors/api_message_handler.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/base_response.dart';
import '../../../../core/utils/constant.dart';
import '../../../../core/utils/endpoint.dart';

class ReservationsRemoteDataSrcImpl implements ReservationsRemoteDataSource {
  ReservationsRemoteDataSrcImpl(this._client);

  final http.Client _client;

  @override
  Future<GetReservationsResponse> getReservations({required String id}) async {
    http.Response? response;
    try {
      response = await _client
          .get(
            Uri.parse(Endpoints.baseUrl + Endpoints.reservations),
            headers: headersWithToken(id),
          )
          .timeout(Endpoints.connectionTimeout);

      if (response.statusCode != 200 && response.statusCode != 201) {
        BaseResponse result = BaseResponse.fromJson(jsonDecode(response.body));
        throw APIException(
            message: result.message, statusCode: response.statusCode);
      }

      return GetReservationsResponse.fromJson(jsonDecode(response.body));
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(
          message: catchExceptions(response, e),
          statusCode: response != null ? response.statusCode : 505);
    }
  }

  @override
  Future<CheckCouponResponse> checkCoupon(
      {required String code, required String salonId}) async {
    http.Response? response;
    try {
      response = await _client
          .post(Uri.parse(Endpoints.baseUrl + Endpoints.coupon),
              headers: headers,
              body: jsonEncode({"code": code, "salon_id": salonId}))
          .timeout(Endpoints.connectionTimeout);

      if (response.statusCode != 200 && response.statusCode != 201) {
       log(response.body.toString());
        BaseResponse result = BaseResponse.fromJson(response.body);
        throw APIException(
            message: result.message, statusCode: response.statusCode);
      }

      return CheckCouponResponse.fromJson(jsonDecode(response.body));
    } on APIException {
      rethrow;
    } catch (e) {
      log(e.toString());
      throw APIException(
          message: catchExceptions(response, e),
          statusCode: response != null ? response.statusCode : 505);
    }
  }

  @override
  Future<AddReservationResponse> addReservation({required DataMap data}) async {
    http.Response? response;
    try {
      String token = Prefs.getString(Prefs.TOKEN) ?? '';

      response = await _client
          .post(Uri.parse(Endpoints.baseUrl + Endpoints.reservations),
              headers: {
                'Authorization': 'Bearer $token',
                'Content-Type': 'application/json',
              },
              body: jsonEncode(data))
          .timeout(Endpoints.connectionTimeout);

      if (response.statusCode != 200 && response.statusCode != 201) {
        log(response.body.toString());
        log(response.statusCode.toString());
        BaseResponse result = BaseResponse.fromJson(response.body);
        throw APIException(
            message: result.message, statusCode: response.statusCode);
      }

      return AddReservationResponse.fromJson(jsonDecode(response.body));
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(
          message: catchExceptions(response, e),
          statusCode: response != null ? response.statusCode : 505);
    }
  }
}
