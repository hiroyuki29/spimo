import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spimo/features/account/presentation/controller/user_controller.dart';
import 'package:spimo/features/books/domain/model/book.dart';
import 'package:spimo/features/books/domain/repository/book_storage_repository.dart';
import 'package:spimo/features/books/use_case/books_use_case.dart';
import 'package:spimo/features/memos/domain/model/memo.dart';
import 'package:spimo/features/memos/use_case/memos_use_case.dart';

final currentBookControllerProvider =
    StateNotifierProvider.autoDispose<CurrentBookController, AsyncValue<Book?>>(
        (ref) {
  return CurrentBookController(
    bookStorageRepository: ref.watch(bookStorageProvider),
    userController: ref.watch(userControllerProvider.notifier),
    memosUseCase: ref.watch(memosUseCaseProvider),
    booksUseCase: ref.watch(booksUseCaseProvider),
  );
});

class CurrentBookController extends StateNotifier<AsyncValue<Book?>> {
  CurrentBookController({
    required this.bookStorageRepository,
    required this.userController,
    required this.memosUseCase,
    required this.booksUseCase,
  }) : super(const AsyncData(null)) {
    fetchCurrentBook();
  }
  final BookStorageRepository bookStorageRepository;
  final UserController userController;
  final MemosUseCase memosUseCase;
  final BooksUseCase booksUseCase;

  Future<void> setCurrentBookId(String bookId) async {
    await bookStorageRepository.setCurrentBookId(
      userId: userController.state!.id,
      bookId: bookId,
    );
    await userController.setCurrentBookId(bookId);
    await fetchCurrentBook();
  }

  Future<void> resetCurrentBookId(String bookId) async {
    await bookStorageRepository.resetCurrentBookId(
      userId: userController.state!.id,
    );
    await userController.resetCurrentBookId();
    await fetchCurrentBook();
  }

  Future<void> fetchCurrentBook() async {
    state = const AsyncLoading();
    if (userController.state!.currentBookId == '') {
      state = const AsyncData(null);
      return;
    }

    state = AsyncData(await booksUseCase.fetchBook(
      userId: userController.state!.id,
      bookId: userController.state!.currentBookId,
    ));
  }

  Future<void> reset() async {
    state = const AsyncData(null);
  }

  // Future<void> fetchBookMemos() async {
  //   state = const AsyncLoading();
  //   if (userController.state!.currentBookId != '') {
  //     state = AsyncData(await booksUseCase.fetchBook(
  //       userId: userController.state!.id,
  //       bookId: userController.state!.currentBookId,
  //     ));
  //   }
  // }

  Future<void> addMemo({required String bookId, required Memo memo}) async {
    await memosUseCase.addMemo(userId: userController.state!.id, memo: memo);
    fetchCurrentBook();
  }

  Future<void> removeMemo({required Memo memo}) async {
    await memosUseCase.removeMemo(userId: userController.state!.id, memo: memo);
    fetchCurrentBook();
  }
}
