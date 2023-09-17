import 'package:json_annotation/json_annotation.dart';
import 'package:spavation/core/utils/typedef.dart';

import '../../data/models/banner_model.dart';

part 'get_banners_response.g.dart';

@JsonSerializable()
class GetBannersResponse {
  GetBannersResponse(
    this.banners,
    this.status,
  );

  final List<BannerModel>? banners;
  final int status;

  factory GetBannersResponse.fromJson(DataMap json) =>
      _$GetBannersResponseFromJson(json);

  DataMap toJson() => _$GetBannersResponseToJson(this);
}
