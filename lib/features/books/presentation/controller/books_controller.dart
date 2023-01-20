import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spimo/features/books/domain/model/book.dart';
import 'package:spimo/features/books/domain/repository/book_storage_repository.dart';

final booksControllerProvider =
    StateNotifierProvider<BooksController, AsyncValue<List<Book>>>((ref) {
  return BooksController(bookStorageRepository: ref.watch(bookStorageProvider));
});

class BooksController extends StateNotifier<AsyncValue<List<Book>>> {
  BooksController({required this.bookStorageRepository})
      : super(const AsyncData([])) {
    fetchBooks();
  }
  final BookStorageRepository bookStorageRepository;

  Future<void> fetchBooks() async {
    state = const AsyncLoading();
    state = AsyncData(await bookStorageRepository.fetchBooks());
  }

  Future<void> addBook(Book book) async {
    bookStorageRepository.addBook(book);
    state = AsyncData(await bookStorageRepository.fetchBooks());
  }

  Future<void> removeBook(Book book) async {
    bookStorageRepository.removeBook(book);
    state = AsyncData(await bookStorageRepository.fetchBooks());
  }
}
