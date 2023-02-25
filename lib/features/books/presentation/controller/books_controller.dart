import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spimo/features/account/presentation/controller/user_controller.dart';
import 'package:spimo/features/books/domain/model/book.dart';
import 'package:spimo/features/books/domain/repository/book_storage_repository.dart';

enum BookSortType {
  dateTime,
  ranking,
}

final bookSortTypeProvider =
    StateProvider<BookSortType>((ref) => BookSortType.dateTime);

final sortedBookListProvider =
    Provider.autoDispose<AsyncValue<List<Book>>>((ref) {
  final sortType = ref.watch(bookSortTypeProvider);
  final bookList = ref.watch(booksControllerProvider);
  if (!bookList.hasValue) {
    return const AsyncData([]);
  }
  List<Book> sortedList = [];
  switch (sortType) {
    case BookSortType.dateTime:
      sortedList = List<Book>.from(bookList.requireValue)
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return AsyncValue.data(sortedList);
    case BookSortType.ranking:
      sortedList = List<Book>.from(bookList.requireValue)
        ..sort((a, b) => b.totalMemoCount.compareTo(a.totalMemoCount));
      return AsyncValue.data(sortedList);
  }
});

final booksControllerProvider =
    StateNotifierProvider.autoDispose<BooksController, AsyncValue<List<Book>>>(
        (ref) {
  final userId = ref.watch(userControllerProvider)?.id ?? '';
  return BooksController(
    bookStorageRepository: ref.watch(bookStorageProvider),
    userId: userId,
  );
});

class BooksController extends StateNotifier<AsyncValue<List<Book>>> {
  BooksController({
    required this.bookStorageRepository,
    required this.userId,
  }) : super(const AsyncData([])) {
    fetchBooks();
  }
  final BookStorageRepository bookStorageRepository;
  final String userId;

  Future<void> fetchBooks() async {
    state = const AsyncLoading();
    state = AsyncData(await bookStorageRepository.fetchBooks(userId));
  }

  Future<void> addBook(Book book) async {
    await bookStorageRepository.addBook(userId: userId, book: book);
    state = AsyncData(await bookStorageRepository.fetchBooks(userId));
  }

  Future<void> removeBook(Book book) async {
    await bookStorageRepository.removeBook(userId: userId, book: book);
    state = AsyncData(await bookStorageRepository.fetchBooks(userId));
  }

  void sortByDate() {
    if (state.hasValue) {
      final sortedList = List<Book>.from(state.requireValue)
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
      state = AsyncValue.data(sortedList);
    }
  }

  void sortByMemoCounts() {
    if (state.hasValue) {
      final sortedList = List<Book>.from(state.requireValue)
        ..sort((a, b) => b.totalMemoCount.compareTo(a.totalMemoCount));
      state = AsyncValue.data(sortedList);
    }
  }
}
