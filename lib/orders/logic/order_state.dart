part of 'order_bloc.dart';

class OrderState {
  final bool isLoading;

  const OrderState({this.isLoading = false});

  OrderState copyWith({bool? isLoading}) {
    return OrderState(isLoading: isLoading ?? this.isLoading);
  }
}
