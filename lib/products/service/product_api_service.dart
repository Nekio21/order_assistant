import 'dart:convert';

import 'package:http/http.dart' as http;

import '../data/product.dart';

class ProductApiServer{
  ProductApiServer._();

  static Future<List<Product>?> fetchProducts() async{
    final uri = Uri.parse('https://dummyjson.com/products?limit=50');
    final response = await http.get(uri);

    if(response.statusCode == 200){
      final Map<String, dynamic> json = jsonDecode(response.body);
      final List products = json['products'];
      return products.map((p) => Product.fromJson(p)).toList();
    }

    return null;
  }
}