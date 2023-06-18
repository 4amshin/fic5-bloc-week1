import 'package:camera/camera.dart';
import 'package:fic_bloc2/data/data_sources/product_datasources.dart';
import 'package:fic_bloc2/data/models/request/product_request_model.dart';
import 'package:fic_bloc2/data/models/response/product_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_product_event.dart';
part 'add_product_state.dart';
part 'add_product_bloc.freezed.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  final ProductDataSources dataSources;
  AddProductBloc(this.dataSources) : super(const _Initial()) {
    on<_AddProduct>(_addProduct);
  }

  Future<void> _addProduct(
    _AddProduct event,
    Emitter<AddProductState> emit,
  ) async {
    emit(const _Loading());
    final uploadImage = await dataSources.uploadImage(event.image);
    uploadImage.fold(
      (error) => emit(_Error(message: error)),
      (dataUpload) async {
        final result = await dataSources.addProduct(event.model.copyWith(
          images: [
            dataUpload.location,
          ],
        ));
        result.fold(
          (error) => emit(_Error(message: error)),
          (data) => emit(_Loaded(model: data)),
        );
      },
    );
  }
}
