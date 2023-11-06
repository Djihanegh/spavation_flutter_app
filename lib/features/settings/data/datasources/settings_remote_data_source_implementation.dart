import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/settings/data/datasources/settings_remote_data_source.dart';
import 'package:spavation/features/settings/domain/entities/get_user_details_response.dart';

import '../../../../core/errors/api_message_handler.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/base_response.dart';
import '../../../../core/utils/constant.dart';
import '../../../../core/utils/endpoint.dart';

class SettingsRemoteDataSrcImpl implements SettingsRemoteDataSource {
  SettingsRemoteDataSrcImpl(this._client);

  final http.Client _client;

  @override
  Future<BaseResponse> deleteUser({required String token}) async {
    http.Response? response;
    try {
      response = await _client.delete(
        Uri.parse(Endpoints.baseUrl + Endpoints.customer),
        headers: headersWithToken(token),
      ).timeout(timeOutDuration);

      if (response.statusCode != 200 && response.statusCode != 201) {
        BaseResponse result = BaseResponse.fromJson(jsonDecode(response.body));
        throw APIException(
            message: result.message, statusCode: response.statusCode);
      }

      return BaseResponse.fromJson(response.body);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(
          message: catchExceptions(response, e),
          statusCode: response != null ? response.statusCode : 505);
    }
  }

  @override
  Future<GetUserDetailsResponse> getUserDetails({required String token}) async {
    http.Response? response;
    try {
      response = await _client.get(
        Uri.parse(Endpoints.baseUrl + Endpoints.customer),
        headers: headers,
      ).timeout(timeOutDuration);

      if (response.statusCode != 200 && response.statusCode != 201) {
        BaseResponse result = BaseResponse.fromJson(jsonDecode(response.body));
        throw APIException(
            message: result.message, statusCode: response.statusCode);
      }

      return GetUserDetailsResponse.fromJson(jsonDecode(response.body));
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(
          message: catchExceptions(response, e),
          statusCode: response != null ? response.statusCode : 505);
    }
  }

  @override
  Future<BaseResponse> updateUser({required DataMap body}) async {
    http.Response? response;
    try {
      response = await _client.post(
          Uri.parse(Endpoints.baseUrl + Endpoints.customer),
          headers: headers,
          body: jsonEncode(body)).timeout(timeOutDuration);

      if (response.statusCode != 200 && response.statusCode != 201) {
        BaseResponse result = BaseResponse.fromJson(jsonDecode(response.body));
        throw APIException(
            message: result.message, statusCode: response.statusCode);
      }

      return BaseResponse.fromJson(response.body);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(
          message: catchExceptions(response, e),
          statusCode: response != null ? response.statusCode : 505);
    }
  }
}
