import 'package:equatable/equatable.dart';

class Product extends Equatable{
    final String name;
    final String description;
    final String imageUrl;
    final double price;

    const Product({required this.name, required this.description, required this.imageUrl, required this.price});

    factory Product.fromJson(Map<String, dynamic> json) {
        return Product(
            name: json['title'],
            description: json['description'],
            imageUrl: json['thumbnail'],
            price: (json['price'] as num).toDouble(),
        );
    }

    @override
    List<Object?> get props => [name, description, price];
}