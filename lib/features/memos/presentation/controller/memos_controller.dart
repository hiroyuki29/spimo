import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spimo/features/books/domain/model/book.dart';
import 'package:spimo/features/books/presentation/controller/current_book_controller.dart';
import 'package:spimo/features/memos/domain/model/memo.dart';
import 'package:spimo/features/memos/use_case/memos_use_case.dart';

final memosControllerProvider =
    StateNotifierProvider<MemosController, AsyncValue<List<Memo>>>((ref) {
  return MemosController(
      memosUseCase: ref.watch(memosUseCaseProvider),
      currentBook: ref.watch(currentBookControllerProvider));
});

class MemosController extends StateNotifier<AsyncValue<List<Memo>>> {
  MemosController({required this.memosUseCase, required this.currentBook})
      : super(const AsyncData([]));

  final MemosUseCase memosUseCase;
  Book? currentBook;

  Future<void> fetchBookMemos() async {
    state = const AsyncLoading();
    if (currentBook != null) {
      state = AsyncData(await memosUseCase.fetchBookMemos(currentBook!.id));
    }
  }

  Future<void> addMemo({required Memo memo}) async {
    await memosUseCase.addMemo(memo: memo);
    if (currentBook != null) {
      state = AsyncData(await memosUseCase.fetchBookMemos(currentBook!.id));
    }
  }

  Future<void> removeMemo({required Memo memo}) async {
    await memosUseCase.removeMemo(memo: memo);
    if (currentBook != null) {
      state = AsyncData(await memosUseCase.fetchBookMemos(currentBook!.id));
    }
  }
}
