import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spimo/features/memos/data/fire_store/repository_imple/firestore_memos_repository.dart';
import 'package:spimo/features/memos/domain/model/memo.dart';

final memoStorageProvider = Provider.autoDispose<MemoStorageRepository>((ref) {
  return FireStoreMemosRepository();
});

abstract class MemoStorageRepository {
  Future<List<Memo>> fetchAllMemos();
  Future<List<Memo>> fetchBookMemos({
    required String userId,
    required String bookId,
  });
  Future<void> addMemo({
    required String userId,
    required Memo memo,
  });
  Future<void> removeMemo({
    required String userId,
    required Memo memo,
  });
}
