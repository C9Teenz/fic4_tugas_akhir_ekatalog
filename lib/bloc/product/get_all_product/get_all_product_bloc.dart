import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:fic4_flutter_auth_bloc/data/datasources/product_datasources.dart';
import 'package:fic4_flutter_auth_bloc/data/models/response/product/product_response_model.dart';

part 'get_all_product_event.dart';
part 'get_all_product_state.dart';

class GetAllProductBloc extends Bloc<GetAllProductEvent, GetAllProductState> {
  final ProductDatasources productDatasources;
  GetAllProductBloc(
    this.productDatasources,
  ) : super(GetAllProductInitial()) {
    on<DoGetAllProductEvent>((event, emit) async {
      emit(GetAllProductLoading());
      final result = await productDatasources.getAllProduct();
      result.fold(
        (l) => emit(GetAllProductError(msg: l)),
        (r) => emit(GetALlProductLoaded(listProduct: r)),
      );
    });
  }
}
