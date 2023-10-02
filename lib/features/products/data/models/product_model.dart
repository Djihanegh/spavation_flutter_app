import 'dart:convert';

import '../../../../core/utils/typedef.dart';
import '../../domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel(
      {required super.id,
      required super.image,
      required super.name,
      required super.createdAt,
      required super.updatedAt,
      required super.status,
      required super.price,
      required super.salonId,
      required super.categoryId,
      required super.description,
      required super.timeFrom,
      required super.timeTo,
      required super.dateFrom,
      required super.dateTo,
      required super.discount});

  factory ProductModel.fromJson(DataMap source) => ProductModel.fromMap(source);

  factory ProductModel.empty() => const ProductModel(
        id: -1,
        image: '',
        name: '',
        createdAt: '',
        updatedAt: '',
        status: '',
        price: '',
        salonId: ' ',
        categoryId: '',
        description: '',
        timeFrom: '',
        timeTo: '',
        dateFrom: '',
        dateTo: '',
        discount: '',
      );

  ProductModel.fromMap(DataMap json)
      : this(
            id: json["id"],
            name: json["name"],
            image: json["image"],
            price: json["price"],
            status: json["status"],
            salonId: json["salon_id"],
            categoryId: json["category_id"],
            description: json["description"],
            timeFrom: json["time_from"],
            timeTo: json["time_to"],
            dateFrom: json["date_from"],
            dateTo: json["date_to"],
            discount: json["discount"],
            createdAt: json["created_at"],
            updatedAt: json["updated_at"]);

  DataMap toMap() => {
        "id": id,
        "name": name,
        "image": image,
        "price": price,
        "status": status,
        "salon_id": salonId,
        "category_id": categoryId,
        "description": description,
        "time_from": timeFrom,
        "time_to": timeTo,
        "date_from": dateFrom,
        "date_to": dateTo,
        "discount": discount,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };

  String toJson() => jsonEncode(toMap());
}
