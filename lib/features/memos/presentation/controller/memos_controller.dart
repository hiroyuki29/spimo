import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spimo/features/books/domain/model/book.dart';
import 'package:spimo/features/books/presentation/controller/current_book_controller.dart';
import 'package:spimo/features/memos/domain/model/memo.dart';
import 'package:spimo/features/memos/domain/repository/memo_storage_repository.dart';

final memosControllerProvider =
    StateNotifierProvider<MemosController, AsyncValue<List<Memo>>>((ref) {
  return MemosController(
      memoStorageRepository: ref.watch(memoStorageProvider),
      currentBook: ref.watch(currentBookControllerProvider));
});

class MemosController extends StateNotifier<AsyncValue<List<Memo>>> {
  MemosController(
      {required this.memoStorageRepository, required this.currentBook})
      : super(const AsyncData([])) {
    if (currentBook != null) {
      fetchBookMemos();
    }
  }

  final MemoStorageRepository memoStorageRepository;
  Book? currentBook;

  Future<void> fetchBookMemos() async {
    state = const AsyncLoading();
    if (currentBook != null) {
      state = AsyncData(
          await memoStorageRepository.fetchBookMemos(currentBook!.id));
    }
  }

  Future<void> addMemo({required Memo memo}) async {
    await memoStorageRepository.addMemo(memo);
    if (currentBook != null) {
      state = AsyncData(
          await memoStorageRepository.fetchBookMemos(currentBook!.id));
    }
  }

  Future<void> removeMemo({required Memo memo}) async {
    await memoStorageRepository.removeMemo(memo);
    if (currentBook != null) {
      state = AsyncData(
          await memoStorageRepository.fetchBookMemos(currentBook!.id));
    }
  }
}
