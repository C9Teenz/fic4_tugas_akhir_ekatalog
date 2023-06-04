// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'edit_product_bloc.dart';

@immutable
abstract class EditProductState {}

class EditProductInitial extends EditProductState {}
class EditProductLoading extends EditProductState {}
class EditProductLoaded extends EditProductState {

}
