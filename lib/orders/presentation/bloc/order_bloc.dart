import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:order_assistant/core/data/models/product.dart';
import 'package:order_assistant/core/errors/failures.dart';
import 'package:order_assistant/orders/presentation/models/order_display.dart';
import 'package:order_assistant/orders/data/datasources/order_ai_service.dart';
import 'package:order_assistant/core/data/datasources/product_api_service.dart';

part 'order_state.dart';
part 'order_event.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {

  OrderBloc() : super(const OrderState()) {
    on<SendEmail>(_onSendEmail);
  }

  void _onSendEmail(SendEmail event, Emitter<OrderState> emit) async {
    emit(state.copyWith(isLoading: true));

    final products = await ProductApiServer.fetchProducts();

    if(products.isFailure == true){
      emit(state.copyWith(error: products.failure));
    }

    final result = await OrderAIService.sendPrompt(event.text);

    final fuse = Fuzzy(
      products.data ?? [],
      options: FuzzyOptions(
        threshold: 0.1,
        findAllMatches: true,
        keys: [
          WeightedKey(name: 'name', getter: (dynamic p) => (p as Product).name, weight: 1.0),
        ],
      ),
    );

    if (result.isSuccess) {
      final list = result.data?.map((o){
        final result = fuse.search(o.name);

        if (result.isNotEmpty) {
          final product = result.first.item;
          return OrderDisplay(
            name: product.name,
            imageUrl: product.imageUrl,
            isFitted: true,
            amount: o.amount,
            price: product.price,
          );
        }

        return OrderDisplay(name: o.name, isFitted: false, amount: o.amount);
      }).toList();

      emit(state.copyWith(orders: list));
    }else{
      emit(state.copyWith(error: result.failure));
    }

    emit(state.copyWith(isLoading: false, error: null));
  }
}
