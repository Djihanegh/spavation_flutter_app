import 'dart:convert';

import 'package:spavation/features/banners/domain/entities/get_banners_response.dart';
import 'package:http/http.dart' as http;

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/constant.dart';
import '../../../../core/utils/endpoint.dart';
import 'banners_remote_data_source.dart';

class BannersRemoteDataSrcImpl implements BannersRemoteDataSource {
  BannersRemoteDataSrcImpl(this._client);

  final http.Client _client;

  @override
  Future<GetBannersResponse> getBanners() async {
    try {
      final response = await _client.get(
        Uri.parse(Endpoints.baseUrl + Endpoints.banners),
        headers: headers,
      ).timeout(Endpoints.connectionTimeout);;

      if (response.statusCode != 200 && response.statusCode != 201) {
        GetBannersResponse result =
            GetBannersResponse.fromJson(jsonDecode(response.body));
        throw APIException(message: '', statusCode: response.statusCode);
      }

      return GetBannersResponse.fromJson(jsonDecode(response.body));
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
