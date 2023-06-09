part of 'get_product_pagination_bloc.dart';

abstract class GetProductPaginationEvent {}

class GetProductPaginationStarted extends GetProductPaginationEvent {}

class GetProductPaginationLoadMore extends GetProductPaginationEvent {}
