
import 'package:flutter_bloc/flutter_bloc.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState>{
  OrderBloc() : super(OrderState()){
    on<SendEmail>(_onSendEmail);
  }

  void _onSendEmail(SendEmail event, Emitter<OrderState> emit) async{
    emit(state.copyWith(isLoading: true));

    print("Info: ${event.text}");

    emit(state.copyWith(isLoading: false));
  }
}