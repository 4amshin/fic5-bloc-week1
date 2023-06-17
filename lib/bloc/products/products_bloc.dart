import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fic_bloc2/data/data_sources/product_datasources.dart';
import 'package:fic_bloc2/data/models/response/product_response_model.dart';
import 'package:meta/meta.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductDataSources dataSources;
  ProductsBloc(this.dataSources) : super(ProductsInitial()) {
    on<GetProductsEvent>(_getProducts);
    on<LoadMoreProductsEvent>(_loadMoreProducts);
    on<AddSingleProductsEvent>(_addSingleProduct);
    on<ClearProductsEvent>(_clearProduct);
  }

  int itemLimit = 50;

  Future<void> _getProducts(
    GetProductsEvent event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());
    final result =
        await dataSources.getPaginationProduct(offset: 0, limit: itemLimit);
    result.fold(
      (error) => emit(ProductsError(message: error)),
      (listProduct) {
        bool isNext = listProduct.length == itemLimit;
        emit(ProductsLoaded(
          data: listProduct,
          isNext: isNext,
        ));
      },
    );
  }

  Future<void> _loadMoreProducts(
    LoadMoreProductsEvent event,
    Emitter<ProductsState> emit,
  ) async {
    final currentState = state as ProductsLoaded;
    final result = await dataSources.getPaginationProduct(
        offset: currentState.offset + 10, limit: itemLimit);

    result.fold(
      (error) => emit(ProductsError(message: error)),
      (listProduct) {
        bool isNext = listProduct.length == itemLimit;
        emit(ProductsLoaded(
          data: [...currentState.data, ...listProduct],
          offset: currentState.offset + itemLimit,
          isNext: isNext,
        ));
      },
    );
  }

  Future<void> _addSingleProduct(
    AddSingleProductsEvent event,
    Emitter<ProductsState> emit,
  ) async {
    final currentState = state as ProductsLoaded;
    emit(ProductsLoaded(
      data: [
        ...currentState.data,
        event.data,
      ],
    ));
  }

  Future<void> _clearProduct(
    ClearProductsEvent event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsInitial());
  }
}
