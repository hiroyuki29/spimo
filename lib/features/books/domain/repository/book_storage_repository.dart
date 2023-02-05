import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spimo/features/books/data/fire_store/repository_impl/firestore_books_repository.dart';
import 'package:spimo/features/books/domain/model/book.dart';

final bookStorageProvider = Provider.autoDispose<BookStorageRepository>((ref) {
  return FirestoreBooksRepository();
});

abstract class BookStorageRepository {
  Future<List<Book>> fetchBooks(String userId);
  Future<Book> fetchBook({required String userId, required String bookId});
  Future<void> setCurrentBookId(
      {required String userId, required String bookId});
  Future<void> addBook({required String userId, required Book book});
  Future<void> removeBook({required String userId, required Book book});
}
