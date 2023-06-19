// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fic4_flutter_auth_bloc/data/datasources/product_datasources.dart';

import '../../../data/models/request/product_model.dart';
import '../../../data/models/response/product/product_response_model.dart';

part 'update_product_cubit.freezed.dart';
part 'update_product_state.dart';

class UpdateProductCubit extends Cubit<UpdateProductState> {
  final ProductDatasources data;
  UpdateProductCubit(
    this.data,
  ) : super(const UpdateProductState.initial());

  void updateProduct(ProductModel model,int id)async{
    emit(const UpdateProductState.loading());
    final result = await data.updateProductCubit(model,id);
    result.fold(
      (l) => emit(UpdateProductState.error(l)),
      (r) => emit(UpdateProductState.loaded(r)),
    );
  }
}
