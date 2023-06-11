import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fic4_flutter_auth_bloc/data/models/request/product_model.dart';
import 'package:fic4_flutter_auth_bloc/data/models/response/product_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

import '../models/request/product_model_update.dart';

class ProductDatasources {
  final dio = Dio();
  Future<ProductResponseModel> createProduct(ProductModel model) async {
    // try {
 
    var headers = {'Content-Type': 'application/json'};

    final response = await http.post(
      Uri.parse('https://api.escuelajs.co/api/v1/products'),
      headers: headers,
      body: model.toJson(),
    );

    return ProductResponseModel.fromJson(response.body);
    // } catch (e) {

    // }
  }

  // Future<ProductResponseModel> updateProduct(
  //     ProductModelUpdate model, int id) async {
  //   final response = await http.put(
  //     Uri.parse('https://api.escuelajs.co/api/v1/products/$id'),
  //     body: model.toJson(),
  //   );
  //   if (response.statusCode == 200) {
  //     print(model.toJson());
  //     return ProductResponseModel.fromJson(response.body);
  //   } else {
  //     throw Exception('Failed to update product.');
  //   }
  // }
  Future<ProductResponseModel> updateProduct(
      ProductModelUpdate model, int id) async {
    // final datas = ProductModel.fromMap({
    //   "title": model.title,
    //   "price": model.price,
    //   "description": model.description
    // });
    final response = await dio.put(
        'https://api.escuelajs.co/api/v1/products/$id',
        data: model.toMap());
    if (response.statusCode == 200) {
      return ProductResponseModel.fromMap(response.data);
    } else {
      throw Exception('Failed to update product.');
    }
  }

  Future<ProductResponseModel> getProductById(int id) async {
    final response = await http.get(
      Uri.parse('https://api.escuelajs.co/api/v1/products/$id'),
    );

    return ProductResponseModel.fromJson(response.body);
  }

  Future<List<ProductResponseModel>> getAllProduct() async {
    final response = await http.get(
      Uri.parse('https://api.escuelajs.co/api/v1/products'),
    );

    final result = List<ProductResponseModel>.from(jsonDecode(response.body)
        .map((x) => ProductResponseModel.fromMap(x))).toList();

    return result;
  }

  Future<List<ProductResponseModel>> getProductPagination() async {
    final response = await http.get(
        Uri.parse(
            'https://api.escuelajs.co/api/v1/products/?offset=0&limit=10'),
        headers: {'Content-Type': 'application/json'});

    final result = List<ProductResponseModel>.from(jsonDecode(response.body)
        .map((x) => ProductResponseModel.fromMap(x))).toList();
    return result;
  }

  Future<List<ProductResponseModel>> laodMoreProductPagination(
      int page, int size) async {
    final response = await http.get(
        Uri.parse(
            'https://api.escuelajs.co/api/v1/products/?offset=${page * size}&limit=$size'),
        headers: {'Content-Type': 'application/json'});

    final result = List<ProductResponseModel>.from(jsonDecode(response.body)
        .map((x) => ProductResponseModel.fromMap(x))).toList();
    return result;
  }
}
