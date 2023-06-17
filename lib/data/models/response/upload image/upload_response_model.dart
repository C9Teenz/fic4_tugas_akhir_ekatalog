// To parse this JSON data, do
//
//     final uploadResponseModel = uploadResponseModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'upload_response_model.freezed.dart';
part 'upload_response_model.g.dart';

UploadResponseModel uploadResponseModelFromJson(String str) => UploadResponseModel.fromJson(json.decode(str));

String uploadResponseModelToJson(UploadResponseModel data) => json.encode(data.toJson());

@freezed
class UploadResponseModel with _$UploadResponseModel {
    const factory UploadResponseModel({
        required String originalname,
        required String filename,
        required String location,
    }) = _UploadResponseModel;

    factory UploadResponseModel.fromJson(Map<String, dynamic> json) => _$UploadResponseModelFromJson(json);
}
