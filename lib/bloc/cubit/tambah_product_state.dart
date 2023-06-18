part of 'tambah_product_cubit.dart';

@freezed
class TambahProductState with _$TambahProductState {
  const factory TambahProductState.initial() = _Initial;
  const factory TambahProductState.loading() = _Loading;
  const factory TambahProductState.loaded(ProductResponseModel model) = _Loaded;
  const factory TambahProductState.error(String message) = _Error;
}
