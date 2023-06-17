part of 'add_product_bloc.dart';

@freezed
class AddProductState with _$AddProductState {
  const factory AddProductState.initial() = _Initial;
  const factory AddProductState.loading() = _Loading;
  const factory AddProductState.loaded({required ProductResponseModel model}) =
      _Loaded;
  const factory AddProductState.error({required String message}) = _Error;
}
