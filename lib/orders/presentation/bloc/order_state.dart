part of 'order_bloc.dart';

class OrderState {
  final bool isLoading;
  final List<OrderDisplay>? orders;
  final Failure? error;

  const OrderState({this.isLoading = false, this.orders, this.error});

  OrderState copyWith({bool? isLoading, List<OrderDisplay>? orders, Failure? error}) {
    return OrderState(
      isLoading: isLoading ?? this.isLoading,
      orders: orders ?? this.orders,
      error: error ?? this.error
    );
  }
}
