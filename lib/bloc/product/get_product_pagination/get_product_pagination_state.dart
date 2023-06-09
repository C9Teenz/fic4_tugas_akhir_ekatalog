// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_product_pagination_bloc.dart';

abstract class GetProductPaginationState {}

enum Status { initial, loading, loaded, error }

class GetProductPaginationInitial extends GetProductPaginationState {}

class GetProductPaginationLoading extends GetProductPaginationState {}

class GetProductPaginationLoaded extends GetProductPaginationState {
  Status? status;
  List<ProductResponseModel>? products;
  int? page = 0;
  int? size = 10;
  bool? hasMore = true;
  GetProductPaginationLoaded({
    this.status,
    this.products,
    this.page = 0,
    this.size = 10,
    this.hasMore = true,
  });
  GetProductPaginationLoaded copyWith({
    Status? status,
    List<ProductResponseModel>? products,
    int? page,
    int? size,
    bool? hasMore,
  }) {
    return GetProductPaginationLoaded(
      status: status ?? this.status,
      products: products ?? this.products,
      page: page ?? this.page,
      size: size ?? this.size,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}
