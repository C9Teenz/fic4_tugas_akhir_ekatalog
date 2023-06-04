part of 'get_one_product_bloc.dart';

@immutable
abstract class GetOneProductEvent {}

class DoGetOneProductEvent extends GetOneProductEvent {
  final int id;
  DoGetOneProductEvent({required this.id});
}
