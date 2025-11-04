import 'package:equatable/equatable.dart';

class Order extends Equatable{
  final String name;
  final int amount;

  const Order({required this.name, required this.amount});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      name: json['name'],
      amount: (json['amount'] as num).toInt(),
    );
  }

  @override
  List<Object?> get props => [name, amount];
}