import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spimo/features/account/presentation/controller/user_controller.dart';
import 'package:spimo/features/books/domain/model/book.dart';
import 'package:spimo/features/books/presentation/controller/current_book_controller.dart';
import 'package:spimo/features/memos/domain/model/memo.dart';
import 'package:spimo/features/memos/use_case/memos_use_case.dart';

final memosControllerProvider =
    StateNotifierProvider.autoDispose<MemosController, AsyncValue<List<Memo>>>(
        (ref) {
  return MemosController(
    memosUseCase: ref.watch(memosUseCaseProvider),
    currentBook: ref.watch(currentBookControllerProvider),
    userId: ref.watch(userControllerProvider)!.id,
  );
});

class MemosController extends StateNotifier<AsyncValue<List<Memo>>> {
  MemosController({
    required this.memosUseCase,
    required this.currentBook,
    required this.userId,
  }) : super(const AsyncData([]));

  final MemosUseCase memosUseCase;
  Book? currentBook;
  String userId;

  Future<void> fetchBookMemos() async {
    state = const AsyncLoading();
    if (currentBook != null) {
      state = AsyncData(await memosUseCase.fetchBookMemos(
          userId: userId, bookId: currentBook!.id));
    }
  }

  Future<void> addMemo({required Memo memo}) async {
    await memosUseCase.addMemo(userId: userId, memo: memo);
    if (currentBook != null) {
      state = AsyncData(await memosUseCase.fetchBookMemos(
          userId: userId, bookId: currentBook!.id));
    }
  }

  Future<void> removeMemo({required Memo memo}) async {
    await memosUseCase.removeMemo(userId: userId, memo: memo);
    if (currentBook != null) {
      state = AsyncData(await memosUseCase.fetchBookMemos(
          userId: userId, bookId: currentBook!.id));
    }
  }
}
