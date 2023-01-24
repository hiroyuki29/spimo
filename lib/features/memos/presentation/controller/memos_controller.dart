import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spimo/features/books/domain/model/book.dart';
import 'package:spimo/features/memos/domain/model/memo.dart';
import 'package:spimo/features/memos/domain/repository/memo_storage_repository.dart';

final memosControllerProvider =
    StateNotifierProvider<MemosController, AsyncValue<List<Memo>>>((ref) {
  return MemosController(memoStorageRepository: ref.watch(memoStorageProvider));
});

class MemosController extends StateNotifier<AsyncValue<List<Memo>>> {
  MemosController({required this.memoStorageRepository})
      : super(const AsyncData([]));

  final MemoStorageRepository memoStorageRepository;

  Future<void> fetchBookMemos(Book book) async {
    state = const AsyncLoading();
    state = AsyncData(await memoStorageRepository.fetchBookMemos(book));
  }

  Future<void> addMemo({required Book book, required Memo memo}) async {
    await memoStorageRepository.addMemo(memo);
    state = AsyncData(await memoStorageRepository.fetchBookMemos(book));
  }

  Future<void> removeMemo({required Book book, required Memo memo}) async {
    await memoStorageRepository.removeMemo(memo);
    state = AsyncData(await memoStorageRepository.fetchBookMemos(book));
  }
}
