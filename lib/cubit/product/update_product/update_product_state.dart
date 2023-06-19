part of 'update_product_cubit.dart';

@freezed
class UpdateProductState with _$UpdateProductState {
  const factory UpdateProductState.initial() = _Initial;
  const factory UpdateProductState.loading() = _Loading;
  const factory UpdateProductState.loaded(ProductResponseModel data) = _Loaded;
  const factory UpdateProductState.error(String msg) = _Error;
}
