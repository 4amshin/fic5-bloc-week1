// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'products_bloc.dart';

@immutable
abstract class ProductsState extends Equatable {}

class ProductsInitial extends ProductsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ProductsLoading extends ProductsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ProductsLoaded extends ProductsState {
  final List<ProductResponseModel> data;
  final int offset;
  final int limit;
  final bool isNext;
  ProductsLoaded({
    required this.data,
    this.offset = 0,
    this.limit = 50,
    this.isNext = false,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [data, offset, limit, isNext];
}

class ProductsError extends ProductsState {
  final String message;
  ProductsError({
    required this.message,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
