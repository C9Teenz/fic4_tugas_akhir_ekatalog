import 'package:fic4_flutter_auth_bloc/data/models/response/product/product_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:fic4_flutter_auth_bloc/data/datasources/product_datasources.dart';
import 'package:fic4_flutter_auth_bloc/data/models/request/product_model.dart';

part 'create_product_event.dart';
part 'create_product_state.dart';

class CreateProductBloc extends Bloc<CreateProductEvent, CreateProductState> {
  final ProductDatasources productDatasources;
  CreateProductBloc(
    this.productDatasources,
  ) : super(CreateProductInitial()) {
    on<DoCreateProductEvent>((event, emit) async {
      emit(CreateProductLoading());
      final result = await productDatasources.createProduct(event.productModel);
      // emit(CreateProductLoaded(productResponseModel: result));
      result.fold(
        (l) => emit(CreateProductError(msg: l)),
        (r) => emit(CreateProductLoaded(productResponseModel: r)),
      );
    });
  }
}
