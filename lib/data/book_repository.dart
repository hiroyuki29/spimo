import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spimo/domain/book/google_books_api_response.dart';
import 'package:http/http.dart' as http;

final bookProvider = Provider<BookRepository>((ref) {
  return BookRepository();
});

class BookRepository {
  BookRepository();

  Future<GoogleBooksApiResponse> getBooks(String keyword) async {
    var url =
        Uri.https('www.googleapis.com', '/books/v1/volumes', {'q': keyword});

    final response = await http.get(url);
    if (response.statusCode == 200) {
      return GoogleBooksApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to connect to webservice');
    }
  }
}
