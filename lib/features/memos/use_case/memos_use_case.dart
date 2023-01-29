import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spimo/features/memos/domain/model/memo.dart';
import 'package:spimo/features/memos/domain/repository/memo_storage_repository.dart';

final memosUseCaseProvider = Provider<MemosUseCase>((ref) {
  return MemosUseCase(memoStorageRepository: ref.watch(memoStorageProvider));
});

class MemosUseCase {
  MemosUseCase({
    required this.memoStorageRepository,
  });

  final MemoStorageRepository memoStorageRepository;

  Future<List<Memo>> fetchBookMemos(String bookId) async {
    List<Memo> memoList = await memoStorageRepository.fetchBookMemos(bookId);
    memoList.sort(((a, b) => a.startPage!.compareTo(b.startPage!)));
    return memoList;
  }

  Future<void> addMemo({required Memo memo}) async {
    await memoStorageRepository.addMemo(memo);
  }

  Future<void> removeMemo({required Memo memo}) async {
    await memoStorageRepository.removeMemo(memo);
  }
}
