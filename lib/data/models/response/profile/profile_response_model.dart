// To parse this JSON data, do
//
//     final profileResponseModel = profileResponseModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'profile_response_model.freezed.dart';
part 'profile_response_model.g.dart';

ProfileResponseModel profileResponseModelFromJson(String str) => ProfileResponseModel.fromJson(json.decode(str));

String profileResponseModelToJson(ProfileResponseModel data) => json.encode(data.toJson());

@freezed
class ProfileResponseModel with _$ProfileResponseModel {
    const factory ProfileResponseModel({
        required int id,
        required String email,
        required String password,
        required String name,
        required String role,
        required String avatar,
        required DateTime creationAt,
        required DateTime updatedAt,
    }) = _ProfileResponseModel;

    factory ProfileResponseModel.fromJson(Map<String, dynamic> json) => _$ProfileResponseModelFromJson(json);
}
