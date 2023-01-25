import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spimo/features/books/data/shared_preference/book_preference.dart';
import 'package:spimo/features/books/domain/model/book.dart';
import 'package:spimo/features/books/domain/repository/book_storage_repository.dart';

final currentBookControllerProvider =
    StateNotifierProvider<CurrentBookController, Book?>((ref) {
  return CurrentBookController(
    pref: ref.watch(bookPreferenceProvider),
    bookStorageRepository: ref.watch(bookStorageProvider),
  );
});

class CurrentBookController extends StateNotifier<Book?> {
  CurrentBookController({
    required this.pref,
    required this.bookStorageRepository,
  }) : super(null) {
    fetchCurrentBook();
  }
  final BookPreference pref;
  final BookStorageRepository bookStorageRepository;

  Future<void> setCurrentBookId(String bookId) async {
    await pref.setCurrentBookId(bookId);
    fetchCurrentBook();
  }

  Future<void> fetchCurrentBook() async {
    final currentBookId = await pref.getCurrentBookId();
    if (currentBookId != null) {
      final currentBook = await bookStorageRepository.fetchBook(currentBookId);
      state = currentBook;
    } else {
      state = null;
    }
  }
}
