import 'package:fic_bloc2/data/data_sources/product_datasources.dart';
import 'package:fic_bloc2/data/models/request/product_request_model.dart';
import 'package:fic_bloc2/data/models/response/product_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_product_event.dart';
part 'update_product_state.dart';
part 'update_product_bloc.freezed.dart';

class UpdateProductBloc extends Bloc<UpdateProductEvent, UpdateProductState> {
  final ProductDataSources dataSources;
  UpdateProductBloc(this.dataSources) : super(const _Initial()) {
    on<_DoUpdate>(_doUpdate);
  }

  Future<void> _doUpdate(
    _DoUpdate event,
    Emitter<UpdateProductState> emit,
  ) async {
    emit(const _Loading());
    final result =
        await dataSources.updateProduct(event.productId, event.model);
    result.fold(
      (error) => emit(_Error(error)),
      (data) => emit(_Loaded(data)),
    );
  }
}
