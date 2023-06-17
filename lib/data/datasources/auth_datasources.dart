import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fic4_flutter_auth_bloc/data/localsources/auth_local_storage.dart';
import 'package:fic4_flutter_auth_bloc/data/models/request/login_model.dart';
import 'package:fic4_flutter_auth_bloc/data/models/request/register_model.dart';

import 'package:fic4_flutter_auth_bloc/data/models/response/profile/profile_response_model.dart';
import 'package:fic4_flutter_auth_bloc/data/models/response/register/register_response_model.dart';
import 'package:http/http.dart' as http;

import '../models/response/login/login_response_model.dart';

class AuthDatasource {
  Future<Either<String, RegisterResponseModel>> register(
      RegisterModel registerModel) async {
    final response = await http.post(
      Uri.parse('https://api.escuelajs.co/api/v1/users/'),
      body: registerModel.toMap(),
    );
    //toMap disini merubah dari objectclass ke Map
    //jika ingin mengirim sebuah json maka gunakan toJson serta tambahkan header

    // final result = RegisterResponseModel.fromJson(response.body);
    // return result;
    if (response.statusCode == 201) {
      return Right(RegisterResponseModel.fromJson(jsonDecode(response.body)));
    } else {
      return const Left("Register Failed");
    }
  }

  Future<Either<String, LoginResponseModel>> login(
      LoginModel loginModel) async {
    final response = await http.post(
      Uri.parse('https://api.escuelajs.co/api/v1/auth/login'),
      body: loginModel.toMap(),
    );

    // final result = LoginResponseModel.fromJson(response.body);
    // return result;
    if (response.statusCode == 201) {
      LoginResponseModel data =
          LoginResponseModel.fromJson(jsonDecode(response.body));
      print(data.accessToken);
      return Right(data);
    } else {
      return const Left("Login Failed");
    }
  }

  static Future<Either<String,ProfileResponseModel>> getProfile() async {
    final token = await AuthLocalStorage().getToken();
    var headers = {'Authorization': 'Bearer $token'};
    // final response = await http.get(
    //   Uri.parse('https://api.escuelajs.co/api/v1/auth/profile'),
    //   headers: headers,
    // );

    // // final result = ProfileResponseModel.fromJson(response.body);
    // if(response.statusCode==200){
    //   return Right(ProfileResponseModel.fromJson(response.body));
    // }else{
    //   return const Left("Get Profile Failed");
    // }
  
      final response = await http.get(
        Uri.parse('https://api.escuelajs.co/api/v1/auth/profile'),
        headers: headers,
      );
    if(response.statusCode==200){
      return Right(ProfileResponseModel.fromJson(jsonDecode(response.body)));
    }else{
      return const Left("Get Profile Failed");
    }
      
  
  }
}
