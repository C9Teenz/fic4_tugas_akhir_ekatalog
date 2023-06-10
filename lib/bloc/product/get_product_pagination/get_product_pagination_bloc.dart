// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:fic4_flutter_auth_bloc/data/datasources/product_datasources.dart';

import '../../../data/models/response/product_response_model.dart';

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
      print(response[0].title);
      emit(state.copyWith(
          size: 10,
          hasMore: response.length > 10,
          page: 1,
          products: response,
          status: Status.loaded));
    });
    on<GetProductPaginationLoadMore>((event, emit) async {
      emit(state.copyWith(status: Status.loading));
      final response =
          await data.laodMoreProductPagination(state.page!, state.size!);

      emit(state.copyWith(
        hasMore: response.length > state.size!,
        status: Status.loaded,
        page: state.page! + 1,
        products: state.products! + response,
      ));
      print(state.products);
    });
  }
}
