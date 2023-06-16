// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:fic4_flutter_auth_bloc/data/datasources/product_datasources.dart';

import '../../../data/models/response/product/product_response_model.dart';

part 'get_one_product_event.dart';
part 'get_one_product_state.dart';

class GetOneProductBloc extends Bloc<GetOneProductEvent, GetOneProductState> {
  final ProductDatasources data;
  GetOneProductBloc(
    this.data,
  ) : super(GetOneProductInitial()) {
    on<DoGetOneProductEvent>((event, emit) async{
      emit(GetOneProductLoading());
 
        final result= await data.getProductById(event.id);
        result.fold(
          (l) => emit(GetOneProductError(msg: l)),
          (r) => emit(GetOneProductLoaded(product: r)),
        );

       
   
    });
  }
}
