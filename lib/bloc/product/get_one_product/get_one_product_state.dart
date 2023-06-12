// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_one_product_bloc.dart';

@immutable
abstract class GetOneProductState {}

class GetOneProductInitial extends GetOneProductState {}
class GetOneProductLoading extends GetOneProductState {}
class GetOneProductError extends GetOneProductState {
  final String msg;
  GetOneProductError({
    required this.msg,
  });
}
class GetOneProductLoaded extends GetOneProductState {
  final ProductResponseModel product;
  GetOneProductLoaded({required this.product});
}
class GetOneProductFailed extends GetOneProductState {}
