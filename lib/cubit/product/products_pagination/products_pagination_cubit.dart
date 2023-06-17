// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fic4_flutter_auth_bloc/data/datasources/product_datasources.dart';

import '../../../data/models/response/product/product_response_model.dart';

part 'products_pagination_cubit.freezed.dart';
part 'products_pagination_state.dart';

class ProductsPaginationCubit extends Cubit<ProductsPaginationState> {
  final ProductDatasources data;
  ProductsPaginationCubit(
    this.data,
  ) : super(const _Initial());

  void getProduct() async {
    emit(const _Loading());
    final result = await data.getPaginationProduct(offset: 0, limit: 10);
    result.fold((l) => {emit(_$_Error(l))}, (r) {
      bool isNext = r.length == 10;
      emit(_$_Loaded(r, 0, 10, isNext));
    });
  }

  void nextProduct(
      {required offset,
      required isNext,
      required limit,
      required List<ProductResponseModel> products}) async {
    final result =
        await data.getPaginationProduct(offset: offset + 10, limit: limit);
    result.fold((l) => {emit(_$_Error(l))}, (r) {
      bool isNext = r.length == limit;
      emit(_$_Loaded([...products, ...r], offset + 10, limit, isNext));
    });
    // state.maybeWhen(
    //   orElse: () {},
    //   loaded: (products, offset, limit, isNext) async {
    //     debugPrint(offset!.toString());
    //     final result = await data.getPaginationProduct(
    //         offset: offset! + 10, limit: limit!);
    //     result.fold((l) => {emit(_$_Error(l))}, (r) {
    //       bool isNext = r.length == limit;
    //       emit(_$_Loaded([...products, ...r], offset + 10, limit, isNext));
    //     });
    //   },
    // );
  }
}
