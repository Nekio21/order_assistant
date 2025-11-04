import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_assistant/core/data/models/product.dart';
import 'package:order_assistant/core/data/datasources/product_api_service.dart';
import 'package:order_assistant/core/errors/failures.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(const ProductState()) {
    on<LoadProducts>(_onLoadProducts);
  }

  void _onLoadProducts(LoadProducts event, Emitter<ProductState> emit) async {
    emit(state.copyWith(isLoading: true));

    final response = await ProductApiServer.fetchProducts();

    if (response.isFailure == true) {
      emit(state.copyWith(error: response.failure));
    } else {
      emit(state.copyWith(products: response.data));
    }

    emit(state.copyWith(isLoading: false,error: null));
  }
}
