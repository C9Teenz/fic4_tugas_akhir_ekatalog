// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:fic4_flutter_auth_bloc/data/datasources/product_datasources.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/request/product_model_update.dart';

part 'edit_product_event.dart';
part 'edit_product_state.dart';

class EditProductBloc extends Bloc<EditProductEvent, EditProductState> {
  final ProductDatasources data;
  EditProductBloc(
    this.data,
  ) : super(EditProductInitial()) {
    on<DoUpdateProductEvent>((event, emit) async {
      emit(EditProductLoading());
      await data.updateProduct(event.productModel, event.id);
      emit(EditProductLoaded());
    });
  }
}
