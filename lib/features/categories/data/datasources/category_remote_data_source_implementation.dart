import 'dart:convert';

import 'package:spavation/features/categories/data/datasources/category_remote_data_source.dart';
import 'package:spavation/features/categories/domain/entities/get_category_response.dart';
import 'package:http/http.dart' as http;

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/constant.dart';
import '../../../../core/utils/endpoint.dart';

class CategoryRemoteDataSrcImpl implements CategoryRemoteDataSource {
  CategoryRemoteDataSrcImpl(this._client);

  final http.Client _client;

  @override
  Future<GetCategoryResponse> getCategory() async {
    try {
      final response = await _client.post(
        Uri.parse(Endpoints.baseUrl + Endpoints.categories),
        headers: headers,
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        GetCategoryResponse result =
            GetCategoryResponse.fromJson(jsonDecode(response.body));
        throw APIException(
            message: result.message, statusCode: response.statusCode);
      }

      return GetCategoryResponse.fromJson(jsonDecode(response.body));
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
