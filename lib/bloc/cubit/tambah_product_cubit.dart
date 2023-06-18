import 'package:camera/camera.dart';
import 'package:fic_bloc2/data/data_sources/product_datasources.dart';
import 'package:fic_bloc2/data/models/request/product_request_model.dart';
import 'package:fic_bloc2/data/models/response/product_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tambah_product_state.dart';
part 'tambah_product_cubit.freezed.dart';

class TambahProductCubit extends Cubit<TambahProductState> {
  final ProductDataSources dataSources;
  TambahProductCubit(
    this.dataSources,
  ) : super(const TambahProductState.initial());

  void tambahProduct({
    required ProductRequestModel model,
    required XFile image,
  }) async {
    emit(const _Loading());
    final uploadResult = await dataSources.uploadImage(image);
    uploadResult.fold(
      (error) => emit(_Error(error)),
      (dataUpload) async {
        final result = await dataSources.addProduct(model.copyWith(
          images: [
            dataUpload.location,
          ],
        ));
        result.fold(
          (error) => emit(_Error(error)),
          (data) => emit(_Loaded(data)),
        );
      },
    );
  }
}
