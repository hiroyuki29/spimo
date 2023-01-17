import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spimo/domain/book/book.dart';
import 'package:http/http.dart' as http;
import 'package:spimo/domain/google_books_apis/google_books_api_response.dart';

final bookProvider = Provider<BookRepository>((ref) {
  return BookRepository();
});

class BookRepository {
  BookRepository();

  Future<List<Book>> getBooks(String keyword) async {
    var url =
        Uri.https('www.googleapis.com', '/books/v1/volumes', {'q': keyword});

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final result = GoogleBooksApiResponse.fromJson(jsonDecode(response.body));
      final googleBooksList = result.items;
      final bookList = googleBooksList.map((e) => e.transferToBook()).toList();
      return bookList;
    } else {
      throw Exception('Failed to connect to webservice');
    }
  }
}
