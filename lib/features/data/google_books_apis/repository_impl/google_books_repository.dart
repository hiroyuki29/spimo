import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spimo/features/data/google_books_apis/model/google_book.dart';
import 'package:spimo/features/data/google_books_apis/model/google_books_api_response.dart';
import 'package:spimo/features/domain/model/book/book.dart';
import 'package:spimo/features/domain/repository/books_repository.dart';

class GoogleBooksRepository implements BooksRepository {
  GoogleBooksRepository();

  @override
  Future<List<Book>> getBookList(String keyword) async {
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

  @override
  Future<Book> getBook(String id) async {
    var url = Uri.https('www.googleapis.com', '/books/v1/volumes/$id');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final result = GoogleBook.fromJson(jsonDecode(response.body));
      final book = result.transferToBook();
      return book;
    } else {
      throw Exception('Failed to connect to webservice');
    }
  }
}
