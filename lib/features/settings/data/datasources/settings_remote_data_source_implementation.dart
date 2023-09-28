import 'dart:convert';
import 'dart:developer';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:spavation/core/services/location_service.dart';
import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/salons/data/datasources/salons_remote_data_source.dart';
import 'package:spavation/features/salons/data/models/salon_model.dart';
import 'package:spavation/features/salons/domain/entities/get_salons_response.dart';
import 'package:spavation/features/settings/data/datasources/settings_remote_data_source.dart';
import 'package:spavation/features/settings/domain/entities/get_user_details_response.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/base_response.dart';
import '../../../../core/utils/constant.dart';
import '../../../../core/utils/endpoint.dart';

class SettingsRemoteDataSrcImpl implements SettingsRemoteDataSource {
  SettingsRemoteDataSrcImpl(this._client);

  final http.Client _client;

  @override
  Future<BaseResponse> deleteUser({required String token}) async {
    try {
      final response = await _client.delete(
        Uri.parse(Endpoints.baseUrl + Endpoints.customer),
        headers: headersWithToken(token),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        BaseResponse result = BaseResponse.fromJson(jsonDecode(response.body));
        throw APIException(
            message: result.message, statusCode: response.statusCode);
      }

      return BaseResponse.fromJson(response.body);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<GetUserDetailsResponse> getUserDetails({required String token}) async {
    try {
      final response = await _client.get(
        Uri.parse(Endpoints.baseUrl + Endpoints.customer),
        headers: headers,
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        BaseResponse result = BaseResponse.fromJson(jsonDecode(response.body));
        throw APIException(
            message: result.message, statusCode: response.statusCode);
      }

      return GetUserDetailsResponse.fromJson(jsonDecode(response.body));
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<BaseResponse> updateUser({required DataMap body}) async {
    try {
      final response = await _client.post(
        Uri.parse(Endpoints.baseUrl + Endpoints.customer),
        headers: headers,
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        BaseResponse result = BaseResponse.fromJson(jsonDecode(response.body));
        throw APIException(
            message: result.message, statusCode: response.statusCode);
      }

      return BaseResponse.fromJson(response.body);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
