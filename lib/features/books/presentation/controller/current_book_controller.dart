import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spimo/features/account/presentation/controller/user_controller.dart';
import 'package:spimo/features/books/domain/model/book.dart';
import 'package:spimo/features/books/domain/repository/book_storage_repository.dart';

final currentBookControllerProvider =
    StateNotifierProvider.autoDispose<CurrentBookController, Book?>((ref) {
  return CurrentBookController(
    bookStorageRepository: ref.watch(bookStorageProvider),
    userController: ref.watch(userControllerProvider.notifier)!,
  );
});

class CurrentBookController extends StateNotifier<Book?> {
  CurrentBookController({
    required this.bookStorageRepository,
    required this.userController,
  }) : super(null) {
    fetchCurrentBook();
  }
  final BookStorageRepository bookStorageRepository;
  final UserController userController;

  Future<void> setCurrentBookId(String bookId) async {
    await bookStorageRepository.setCurrentBookId(
      userId: userController.state!.id,
      bookId: bookId,
    );
    await userController.setCurrentBookId(bookId);
    await fetchCurrentBook();
  }

  Future<void> fetchCurrentBook() async {
    if (userController.state!.currentBookId != '') {
      final currentBook = await bookStorageRepository.fetchBook(
        userId: userController.state!.id,
        bookId: userController.state!.currentBookId,
      );
      state = currentBook;
    } else {
      state = null;
    }
  }
}
