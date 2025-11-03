import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_assistant/products/data/product.dart';
import 'package:order_assistant/products/service/product_api_service.dart';


part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductState()) {
    on<LoadProducts>(_onLoadProducts);
  }

  void _onLoadProducts(LoadProducts event, Emitter<ProductState> emit) async {
    emit(state.copyWith(isLoading: true));

    final response = await ProductApiServer.fetchProducts();

    if(response != null){
      emit(state.copyWith(products: response));
    }

    emit(state.copyWith(isLoading: false));
  }
}