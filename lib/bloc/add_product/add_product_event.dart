part of 'add_product_bloc.dart';

@freezed
class AddProductEvent with _$AddProductEvent {
  const factory AddProductEvent.addProduct({
    required XFile image,
    required ProductRequestModel model,
  }) = _AddProduct;
}
