// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fic4_flutter_auth_bloc/data/datasources/product_datasources.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/models/request/product_model.dart';
import '../../../data/models/response/product/product_response_model.dart';

part 'add_product_cubit.freezed.dart';
part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  final ProductDatasources data;
  AddProductCubit(
    this.data,
  ) : super(const _Initial());
    void addProduct(ProductModel model, XFile image) async {
    emit(const _Loading());
    final uploadResult = await ProductDatasources.uploadImage(image);
    uploadResult.fold(
      (l) => emit(_Error(l)),
      (dataUpload) async {
        final result = await data.createProduct(model.copyWith(
          images: [
            dataUpload.location,
          ],
        ));
        result.fold(
          (l) => emit(_Error(l)),
          (r) => emit(_Loaded(r)),
        );
      },
    );
}}
