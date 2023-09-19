import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:spavation/features/products/data/datasources/products_remote_data_source.dart';
import 'package:spavation/features/products/domain/entities/get_products_response.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/constant.dart';
import '../../../../core/utils/endpoint.dart';

class ProductsRemoteDataSrcImpl implements ProductsRemoteDataSource {
  ProductsRemoteDataSrcImpl(this._client);

  final http.Client _client;

  @override
  Future<GetProductsResponse> getProducts({required String id}) async {
    try {
      final response = await _client.get(
        Uri.parse(Endpoints.baseUrl + Endpoints.products + id),
        headers: headers,
      );

      log(response.body.toString());

      if (response.statusCode != 200 && response.statusCode != 201) {
        GetProductsResponse result =
            GetProductsResponse.fromJson(jsonDecode(response.body));
        throw APIException(message: '', statusCode: response.statusCode);
      }

      return GetProductsResponse.fromJson(jsonDecode(response.body));
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
