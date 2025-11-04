import 'package:equatable/equatable.dart';

class OrderDisplay extends Equatable {
  final String name;
  final String? imageUrl;
  final bool isFitted;
  final int amount;
  final double? price;

  const OrderDisplay({
    required this.name,
    this.imageUrl,
    required this.isFitted,
    required this.amount,
    this.price,
  });

  double get priceFull => (price ?? 0) * amount;

  @override
  List<Object?> get props => [name, isFitted, amount];
}
