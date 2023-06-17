part of 'add_product_bloc.dart';

@freezed
class AddProductEvent with _$AddProductEvent {
  const factory AddProductEvent.addProduct(ProductRequestModel model) =
      _AddProduct;
}
