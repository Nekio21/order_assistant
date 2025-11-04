part of 'product_bloc.dart';

class ProductState{
  final bool isLoading;
  final List<Product> products;
  final Failure? error;

  const ProductState({
    this.products = const [],
    this.isLoading = false,
    this.error
  });

  ProductState copyWith({
    List<Product>? products,
    bool? isLoading,
    Failure? error,
  }) {
    return ProductState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error
    );
  }
}