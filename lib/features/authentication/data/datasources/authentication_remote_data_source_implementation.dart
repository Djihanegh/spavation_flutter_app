import 'dart:convert';
import 'dart:developer';

import 'package:spavation/core/errors/exceptions.dart';
import 'package:spavation/core/utils/base_response.dart';
import 'package:spavation/core/utils/constant.dart';
import 'package:spavation/core/utils/endpoint.dart';
import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:spavation/features/authentication/domain/entities/create_user_response.dart';
import 'package:spavation/features/authentication/domain/entities/get_user_response.dart';
import 'package:spavation/features/authentication/domain/entities/login_user_response.dart';
import 'package:http/http.dart' as http;

import '../../../../core/cache/cache.dart';
import '../../domain/entities/resend_otp_response.dart';
import '../models/user_model.dart';

class AuthRemoteDataSrcImpl implements AuthenticationRemoteDataSource {
  AuthRemoteDataSrcImpl(this._client);

  final http.Client _client;

  @override
  Future<CreateUserResponse> createUser({required UserModel user}) async {
    try {
      final response = await _client.post(
          Uri.parse(Endpoints.baseUrl + Endpoints.register),
          headers: headers,
          body: user.toJson());

      if (response.statusCode != 200 && response.statusCode != 201) {
        BaseResponse result = BaseResponse.fromJson(response.body);
        throw APIException(
            message: result.message, statusCode: response.statusCode);
      }

      return CreateUserResponse.fromJson(jsonDecode(response.body));
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<LoginUserResponse> loginUser({required UserModel user}) async {
    try {
      final response = await _client.post(
          Uri.parse(Endpoints.baseUrl + Endpoints.login),
          headers: headers,
          body: UserModel.loginUserModel(user).toJson());

      if (response.statusCode != 200 && response.statusCode != 201) {
        BaseResponse result = BaseResponse.fromJson(response.body);
        throw APIException(
            message: result.message, statusCode: response.statusCode);
      }

      LoginUserResponse result =
          LoginUserResponse.fromJson(jsonDecode(response.body));

      Prefs.setString(Prefs.TOKEN, result.token);
      return result;
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<BaseResponse> checkOtp({required String otp}) async {
    try {
      final response = await _client.post(
          Uri.parse(Endpoints.baseUrl + Endpoints.checkOtp),
          headers: headers,
          body: jsonEncode({'otp': otp}));

      if (response.statusCode != 200 && response.statusCode != 201) {
        BaseResponse result = BaseResponse.fromJson(response.body);
        throw APIException(
            message: result.message, statusCode: response.statusCode);
      }

      return BaseResponse.fromMap(jsonDecode(response.body));
    } on APIException {
      rethrow;
    } catch (e) {
      log(e.toString());
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<ResendOtpResponse> resendOtp({required String email}) async {
    try {
      final response = await _client.post(
          Uri.parse(Endpoints.baseUrl + Endpoints.resendOtp),
          headers: headers,
          body: jsonEncode({'email': email}));

      if (response.statusCode != 200 && response.statusCode != 201) {
        BaseResponse result = BaseResponse.fromJson(response.body);
        throw APIException(
            message: result.message, statusCode: response.statusCode);
      }

      return ResendOtpResponse.fromJson(jsonDecode(response.body));
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<GetUserResponse> getUser({required String token}) async {
    try {
      final response = await _client.get(
        Uri.parse(Endpoints.baseUrl + Endpoints.getUser),
        headers: headersWithToken(token),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        BaseResponse result = BaseResponse.fromJson(response.body);
        throw APIException(
            message: result.message, statusCode: response.statusCode);
      }

      return GetUserResponse.fromJson(jsonDecode(response.body));
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<DataMap> checkOtpForgotPassword(
      {required String otp, required String email}) async {
    try {
      final response = await _client.post(
          Uri.parse(Endpoints.baseUrl + Endpoints.forgetPasswordCheckOtp),
          headers: headers,
          body: jsonEncode({'email': email, 'otp': otp}));

      if (response.statusCode != 200 && response.statusCode != 201) {
        DataMap result = jsonDecode(response.body);
        throw APIException(
            message: result['message'], statusCode: response.statusCode);
      }

      return jsonDecode(response.body);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<DataMap> sendOtpForgotPassword({required String email}) async {
    try {
      final response = await _client.post(
          Uri.parse(Endpoints.baseUrl + Endpoints.forgetPasswordSendOtp),
          headers: headers,
          body: jsonEncode({'email': email}));

      log(response.body.toString());

      if (response.statusCode != 200 && response.statusCode != 201) {
        DataMap result = jsonDecode(response.body);
        throw APIException(
            message: result['message'] + ' ' + result['error'],
            statusCode: response.statusCode);
      }

      return jsonDecode(response.body);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<DataMap> updatePassword(
      {required String otp, required String email}) async {
    try {
      final response = await _client.post(
          Uri.parse(Endpoints.baseUrl + Endpoints.updatePassword),
          headers: headers,
          body: jsonEncode({'password': email, 'otp': otp}));

      if (response.statusCode != 200 && response.statusCode != 201) {
        BaseResponse result = BaseResponse.fromJson(response.body);
        throw APIException(
            message: result.message, statusCode: response.statusCode);
      }

      return jsonDecode(response.body);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
