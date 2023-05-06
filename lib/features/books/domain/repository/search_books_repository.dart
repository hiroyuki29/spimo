import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spimo/features/books/data/google_books_apis/repository_impl/google_books_repository.dart';
import 'package:spimo/features/books/domain/model/book.dart';

final searchBooksProvider = Provider<SearchBooksRepository>((ref) {
  return GoogleBooksRepository();
});

abstract class SearchBooksRepository {
  Future<List<Book>> getBookList({required String keyword, int index});
  Future<Book> getBook(String id);
}
