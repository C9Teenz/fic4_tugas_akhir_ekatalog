// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ProfileResponseModel _$$_ProfileResponseModelFromJson(
        Map<String, dynamic> json) =>
    _$_ProfileResponseModel(
      id: json['id'] as int,
      email: json['email'] as String,
      password: json['password'] as String,
      name: json['name'] as String,
      role: json['role'] as String,
      avatar: json['avatar'] as String,
      creationAt: DateTime.parse(json['creationAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$_ProfileResponseModelToJson(
        _$_ProfileResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'password': instance.password,
      'name': instance.name,
      'role': instance.role,
      'avatar': instance.avatar,
      'creationAt': instance.creationAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
