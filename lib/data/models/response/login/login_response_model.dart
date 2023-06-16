// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);


import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'login_response_model.freezed.dart';
part 'login_response_model.g.dart';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

@freezed
class LoginResponseModel with _$LoginResponseModel {
    const factory LoginResponseModel({
        required String accessToken,
        required String refreshToken,
    }) = _LoginResponseModel;

    factory LoginResponseModel.fromJson(Map<String, dynamic> json) => _$LoginResponseModelFromJson(json);
}
