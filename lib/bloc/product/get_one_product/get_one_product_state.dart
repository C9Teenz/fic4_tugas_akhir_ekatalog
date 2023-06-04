part of 'get_one_product_bloc.dart';

@immutable
abstract class GetOneProductState {}

class GetOneProductInitial extends GetOneProductState {}
class GetOneProductLoading extends GetOneProductState {}
class GetOneProductLoaded extends GetOneProductState {
  final ProductResponseModel product;
  GetOneProductLoaded({required this.product});
}
class GetOneProductFailed extends GetOneProductState {}
