part of 'get_all_product_bloc.dart';

@immutable
abstract class GetAllProductState {}

class GetAllProductInitial extends GetAllProductState {}

class GetAllProductLoading extends GetAllProductState {}
class GetAllProductError extends GetAllProductState {
  final String msg;
  GetAllProductError({
    required this.msg,
  });
}

class GetALlProductLoaded extends GetAllProductState {
  final List<ProductResponseModel> listProduct;
  GetALlProductLoaded({
    required this.listProduct,
  });
}
