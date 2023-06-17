// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'products_bloc.dart';

@immutable
abstract class ProductsEvent {}

class GetProductsEvent extends ProductsEvent {}

class LoadMoreProductsEvent extends ProductsEvent {}

class AddSingleProductsEvent extends ProductsEvent {
  final ProductResponseModel data;
  AddSingleProductsEvent({
    required this.data,
  });
}

class ClearProductsEvent extends ProductsEvent {}
