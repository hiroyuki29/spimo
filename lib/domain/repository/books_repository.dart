import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spimo/data/google_books_apis/repository_impl/google_books_repository.dart';
import 'package:spimo/domain/book/book.dart';

final booksProvider = Provider<BooksRepository>((ref) {
  return GoogleBooksRepository();
});

abstract class BooksRepository {
  Future<List<Book>> getBookList(String keyword);
  Future<Book> getBook(String id);
}
