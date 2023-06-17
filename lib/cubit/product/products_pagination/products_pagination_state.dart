part of 'products_pagination_cubit.dart';

@freezed
class ProductsPaginationState with _$ProductsPaginationState {
  const factory ProductsPaginationState.initial() = _Initial;
  const factory ProductsPaginationState.loading() = _Loading;
  const factory ProductsPaginationState.loaded(List<ProductResponseModel> products,int? offset,int? limit,bool? isNext ) = _Loaded;
  const factory ProductsPaginationState.error(String msg) = _Error;
}
