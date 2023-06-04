// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'edit_product_bloc.dart';

@immutable
abstract class EditProductEvent {}

class DoUpdateProductEvent extends EditProductEvent {
  final int id;
  final ProductModelUpdate productModel;
  DoUpdateProductEvent({
    required this.id,
    required this.productModel,
  });
}
