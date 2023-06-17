part of 'update_product_bloc.dart';

@freezed
class UpdateProductEvent with _$UpdateProductEvent {
  const factory UpdateProductEvent.started() = _Started;
  const factory UpdateProductEvent.doUpdate(
      {required int productId, required ProductRequestModel model}) = _DoUpdate;
}
