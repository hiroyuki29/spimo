import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spimo/features/memos/domain/model/memo.dart';
import 'package:spimo/features/memos/domain/repository/memo_storage_repository.dart';

final memosUseCaseProvider = Provider.autoDispose<MemosUseCase>((ref) {
  return MemosUseCase(memoStorageRepository: ref.watch(memoStorageProvider));
});

class MemosUseCase {
  MemosUseCase({
    required this.memoStorageRepository,
  });

  final MemoStorageRepository memoStorageRepository;

  Future<void> addMemo({required String userId, required Memo memo}) async {
    await memoStorageRepository.addMemo(userId: userId, memo: memo);

    if (!memo.isTitle) {
      await memoStorageRepository.stockMemoLength(
          userId: userId,
          addedMemoLength: memo.memoTextLength,
          date: DateTime.now());
    }
  }

  Future<void> removeMemo({required String userId, required Memo memo}) async {
    await memoStorageRepository.removeMemo(userId: userId, memo: memo);
  }
}
