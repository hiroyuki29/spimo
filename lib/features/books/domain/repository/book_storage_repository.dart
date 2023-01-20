import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spimo/features/account/data/firebase_auth/firebase_auth_repository.dart';
import 'package:spimo/features/books/data/fire_store/repository_impl/firestore_books_repository.dart';
import 'package:spimo/features/books/domain/model/book.dart';

final bookStorageProvider = Provider<BookStorageRepository>((ref) {
  return FirestoreBooksRepository(
    userId: ref.watch(firebaseAuthRepositoryProvider).auth.currentUser!.uid,
  );
});

abstract class BookStorageRepository {
  Future<List<Book>> fetchBooks();
  Future<void> addBook(Book book);
  Future<void> removeBook(Book book);
}
