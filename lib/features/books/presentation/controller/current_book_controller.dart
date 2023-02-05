import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spimo/features/account/domain/model/app_user.dart';
import 'package:spimo/features/account/presentation/controller/user_controller.dart';
import 'package:spimo/features/books/domain/model/book.dart';
import 'package:spimo/features/books/domain/repository/book_storage_repository.dart';

final currentBookControllerProvider =
    StateNotifierProvider.autoDispose<CurrentBookController, Book?>((ref) {
  return CurrentBookController(
    bookStorageRepository: ref.watch(bookStorageProvider),
    user: ref.watch(userControllerProvider),
  );
});

class CurrentBookController extends StateNotifier<Book?> {
  CurrentBookController({
    required this.bookStorageRepository,
    required this.user,
  }) : super(null) {
    fetchCurrentBook();
  }
  final BookStorageRepository bookStorageRepository;
  final AppUser? user;

  Future<void> setCurrentBookId(String bookId) async {
    await bookStorageRepository.setCurrentBookId(
        userId: user?.id ?? '', bookId: bookId);
    fetchCurrentBook();
  }

  Future<void> fetchCurrentBook() async {
    if (user != null && user!.currentBookId != '') {
      final currentBook = await bookStorageRepository.fetchBook(
          userId: user!.id, bookId: user!.currentBookId);
      state = currentBook;
    } else {
      state = null;
    }
  }
}
