import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:order_assistant/core/data/models/product.dart';
import 'package:order_assistant/core/errors/failures.dart';
import 'package:order_assistant/core/utils/result.dart';


class ProductApiServer{
  ProductApiServer._();

  static Future<Result<List<Product>>> fetchProducts() async{

    try {
      final uri = Uri.parse('https://dummyjson.com/products?limit=50');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        final List products = json['products'];
        final parsed = products.map((p) => Product.fromJson(p)).toList();
        return Result.success(parsed);
      } else {
        return Result.failure(const ServerFailure());
      }
    } on SocketException{
      return Result.failure(const NetworkFailure());
    } catch (e){
      return Result.failure(const UnknownFailure());
    }
  }
}