import 'dart:convert';
import 'dart:developer';

import 'package:spavation/core/errors/exceptions.dart';
import 'package:spavation/core/utils/base_response.dart';
import 'package:spavation/core/utils/constant.dart';
import 'package:spavation/core/utils/endpoint.dart';
import 'package:spavation/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:spavation/features/authentication/domain/entities/create_user_response.dart';
import 'package:spavation/features/authentication/domain/entities/login_user_response.dart';
import 'package:spavation/features/authentication/domain/entities/user.dart';
import 'package:http/http.dart' as http;

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
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }

      log(response.body.toString());

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
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }

      return LoginUserResponse.fromJson(jsonDecode(response.body));
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
          body: {'otp': otp});

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }

      return BaseResponse.fromJson(jsonDecode(response.body));
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<ResendOtpResponse> resendOtp({required String email}) async {
    try {
      final response = await _client.post(
          Uri.parse(Endpoints.baseUrl + Endpoints.resendOtp),
          headers: headers,
          body: {'email': email});

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }

      return ResendOtpResponse.fromJson(jsonDecode(response.body));
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
