import 'package:bloc/bloc.dart';
import 'package:fic_bloc2/data/data_sources/product_datasoruces.dart';
import 'package:fic_bloc2/data/models/response/product_response_model.dart';
import 'package:meta/meta.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductDataSources dataSources;
  ProductsBloc(this.dataSources) : super(ProductsInitial()) {
    on<GetProductsEvent>(_getProducts);
  }

  Future<void> _getProducts(
    GetProductsEvent event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());
    final result = await dataSources.getAllProduct();
    result.fold(
      (error) => emit(ProductsError(message: error)),
      (listProduct) => emit(ProductsLoaded(data: listProduct)),
    );
  }
}
