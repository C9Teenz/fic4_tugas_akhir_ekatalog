// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ProductResponseModel _$$_ProductResponseModelFromJson(
        Map<String, dynamic> json) =>
    _$_ProductResponseModel(
      id: json['id'] as int,
      title: json['title'] as String,
      price: json['price'] as int,
      description: json['description'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      creationAt: DateTime.parse(json['creationAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      category: Category.fromJson(json['category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ProductResponseModelToJson(
        _$_ProductResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'description': instance.description,
      'images': instance.images,
      'creationAt': instance.creationAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'category': instance.category,
    };

_$_Category _$$_CategoryFromJson(Map<String, dynamic> json) => _$_Category(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
      creationAt: DateTime.parse(json['creationAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$_CategoryToJson(_$_Category instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'creationAt': instance.creationAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
