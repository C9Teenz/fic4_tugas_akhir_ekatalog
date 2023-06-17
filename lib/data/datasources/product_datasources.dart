import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fic4_flutter_auth_bloc/data/models/request/product_model.dart';
import 'package:fic4_flutter_auth_bloc/data/models/response/product/product_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

import '../models/request/product_model_update.dart';

class ProductDatasources {
  final dio = Dio();
  Future<Either<String, ProductResponseModel>> createProduct(
      ProductModel model) async {
    // try {

    var headers = {'Content-Type': 'application/json'};

    final response = await http.post(
      Uri.parse('https://api.escuelajs.co/api/v1/products'),
      headers: headers,
      body: model.toJson(),
    );
    if (response.statusCode == 201) {
      return right(ProductResponseModel.fromJson(jsonDecode(response.body)));
    } else {
      return left('Failed to create product.');
    }

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
  Future<Either<String, ProductResponseModel>> updateProduct(
      ProductModelUpdate model, int id) async {
    final response = await dio.put(
        'https://api.escuelajs.co/api/v1/products/$id',
        data: model.toMap());

    if (response.statusCode == 200) {
      return right(ProductResponseModel.fromJson(response.data));
    } else {
      return left('Failed to update product.');
    }
  }

  Future<Either<String, ProductResponseModel>> getProductById(int id) async {
    final response = await http.get(
      Uri.parse('https://api.escuelajs.co/api/v1/products/$id'),
    );
    if (response.statusCode == 200) {
      return right(ProductResponseModel.fromJson(json.decode(response.body)));
    } else {
      return left('Failed to get product.');
    }
  }

  Future<Either<String, List<ProductResponseModel>>> getAllProduct() async {
    final response = await http.get(
      Uri.parse('https://api.escuelajs.co/api/v1/products'),
    );
    if (response.statusCode == 200) {
      final result = List<ProductResponseModel>.from(jsonDecode(response.body)
          .map((x) => ProductResponseModel.fromJson(x))).toList();
      return right(result);
    } else {
      return left('Failed to get product.');
    }
  }

  Future<Either<String, List<ProductResponseModel>>>
      getProductPagination() async {
    final response = await http.get(
        Uri.parse(
            'https://api.escuelajs.co/api/v1/products/?offset=0&limit=10'),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final result = List<ProductResponseModel>.from(jsonDecode(response.body)
          .map((x) => ProductResponseModel.fromJson(x))).toList();
      return right(result);
    } else {
      return left('Failed to get product.');
    }
  }

  Future<Either<String, List<ProductResponseModel>>> laodMoreProductPagination(
      int page, int size) async {
    final response = await http.get(
        Uri.parse(
            'https://api.escuelajs.co/api/v1/products/?offset=${page * size}&limit=$size'),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final result = List<ProductResponseModel>.from(jsonDecode(response.body)
          .map((x) => ProductResponseModel.fromJson(x))).toList();
      return right(result);
    } else {
      return left('Failed to get product.');
    }
  }
   Future<Either<String, List<ProductResponseModel>>> getPaginationProduct(
      {required int offset, required int limit}) async {
    final response = await http.get(Uri.parse(
        'https://api.escuelajs.co/api/v1/products/?offset=$offset&limit=$limit'));
    if (response.statusCode == 200) {
      return Right(List<ProductResponseModel>.from(jsonDecode(response.body)
          .map((x) => ProductResponseModel.fromJson(x))));
    } else {
      return const Left('get product error');
    }
  }

}
