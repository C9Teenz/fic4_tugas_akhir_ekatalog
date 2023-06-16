// ignore_for_file: public_member_api_docs, sort_constructors_first



import 'package:fic4_flutter_auth_bloc/data/datasources/product_datasources.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/response/product/product_response_model.dart';

part 'get_product_pagination_event.dart';
part 'get_product_pagination_state.dart';

class GetProductPaginationBloc
    extends Bloc<GetProductPaginationEvent, GetProductPaginationLoaded> {
  final ProductDatasources data;
  GetProductPaginationBloc(
    this.data,
  ) : super(GetProductPaginationLoaded(status: Status.initial)) {
    on<GetProductPaginationStarted>((event, emit) async {
      emit(state.copyWith(status: Status.loading));
      final response = await data.getProductPagination();
      response.fold(
          (l) => GetProductPaginationError(msg: l),
          (r) => emit(GetProductPaginationLoaded(
                products: r,
                hasMore: r.length > state.size!,
                status: Status.loaded,
                page: 1,
              )));
    });
    on<GetProductPaginationLoadMore>((event, emit) async {
      emit(state.copyWith(status: Status.loading));
      final response =
          await data.laodMoreProductPagination(state.page!, state.size!);
      response.fold(
        (l) => GetProductPaginationError(msg: l),
        (r) => emit(
          state.copyWith(
            hasMore: r.length > state.size!,
            status: Status.loaded,
            page: state.page! + 1,
            products: state.products! + r,
          ),
        ),
      );
    });
  }
}
