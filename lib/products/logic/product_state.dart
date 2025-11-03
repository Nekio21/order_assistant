part of 'product_bloc.dart';

class ProductState{
  final bool isLoading;
  final List<Product> products;

  const ProductState({
    this.products = const [],
    this.isLoading = false,
  });

  ProductState copyWith({
    List<Product>? products,
    bool? isLoading,
  }) {
    return ProductState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading
    );
  }
}