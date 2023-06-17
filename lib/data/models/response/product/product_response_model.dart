// To parse this JSON data, do
//
//     final productResponseModel = productResponseModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'product_response_model.freezed.dart';
part 'product_response_model.g.dart';

ProductResponseModel productResponseModelFromJson(String str) => ProductResponseModel.fromJson(json.decode(str));

String productResponseModelToJson(ProductResponseModel data) => json.encode(data.toJson());

@freezed
class ProductResponseModel with _$ProductResponseModel {
    const factory ProductResponseModel({
        required int id,
        required String title,
        required int price,
        required String description,
        required List<String> images,
        required DateTime creationAt,
        required DateTime updatedAt,
        required Category category,
    }) = _ProductResponseModel;

    factory ProductResponseModel.fromJson(Map<String, dynamic> json) => _$ProductResponseModelFromJson(json);
}

@freezed
class Category with _$Category {
    const factory Category({
        required int id,
        required String name,
        required String image,
        required DateTime creationAt,
        required DateTime updatedAt,
    }) = _Category;

    factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
}
