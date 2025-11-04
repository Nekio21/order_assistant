import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:order_assistant/core/errors/failures.dart';
import 'package:order_assistant/core/utils/result.dart';
import 'package:order_assistant/orders/data/models/order.dart';

class OrderAIService {
  static const String _baseUrl =
      'https://router.huggingface.co/v1/chat/completions';

  const OrderAIService._();

  static Future<Result<List<Order>>> sendPrompt(String mail) async {
    final prompt =
        '''Otrzymujesz listę produktów, których chce klient. Zwróć odpowiedź **tylko w formacie JSON**, w postaci listy obiektów, każdy obiekt ma dokładnie pola: 

        - 'name' (string)
        - 'amount' (liczba)

    Przykład formatu:

    [
      {'name': 'jabłko', 'amount': 3},
      {'name': 'banan', 'amount': 2}
    ]

    Tekst do przetworzenia: ${mail.trim()}
    
    Nie dodawaj żadnego tekstu ani komentarzy, zwróć wyłącznie jednego JSONa, gdzie szczyt bedzie nazywał się order
    ''';

    final response;
    try {
      response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['API_KEY']}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'messages': [
            {'role': 'user', 'content': prompt},
          ],
          'model': 'openai/gpt-oss-120b:groq',
        }),
      );
    } on SocketException {
      return Result.failure(const NetworkFailure());
    } catch (e) {
      return Result.failure(const UnknownFailure());
    }

    if (response.statusCode == 200) {
      try {
        final data = jsonDecode(response.body);
        final json = data['choices'][0]['message']['content'];
        final List orders = jsonDecode(json)['order'];
        final parsed = orders.map((o) => Order.fromJson(o)).toList();
        return Result.success(parsed);
      } catch (e) {
        return Result.failure(const AIFailure());
      }
    } else if (response.statusCode == 401) {
      return Result.failure(const KeyFailure());
    } else {
      return Result.failure(const ServerFailure());
    }
  }
}
