import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spimo/features/account/data/firebase_auth/firebase_auth_repository.dart';
import 'package:spimo/features/books/domain/model/book.dart';
import 'package:spimo/features/memos/data/fire_store/repository_imple/firestore_memos_repository.dart';
import 'package:spimo/features/memos/domain/model/memo.dart';

final memoStorageProvider = Provider<MemoStorageRepository>((ref) {
  return FireStoreMemosRepository(
    userId: ref.watch(firebaseAuthRepositoryProvider).auth.currentUser!.uid,
  );
});

abstract class MemoStorageRepository {
  Future<List<Memo>> fetchAllMemos();
  Future<List<Memo>> fetchBookMemos(Book book);
  Future<void> addMemo(Memo memo);
  Future<void> removeMemo(Memo memo);
}
