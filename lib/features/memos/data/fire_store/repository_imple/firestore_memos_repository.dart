import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spimo/common_method/datetime_formatter.dart';
import 'package:spimo/features/memos/data/fire_store/model/firestore_memo.dart';
import 'package:spimo/features/memos/data/fire_store/model/firestore_memo_length_stock.dart';
import 'package:spimo/features/memos/domain/model/memo.dart';
import 'package:spimo/features/memos/domain/model/memo_length_stock.dart';
import 'package:spimo/features/memos/domain/repository/memo_storage_repository.dart';

class FireStoreMemosRepository implements MemoStorageRepository {
  FireStoreMemosRepository();

  FirebaseFirestore db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> usersBooks(String userId) {
    return db.collection('users').doc(userId).collection('books');
  }

  @override
  Future<List<MemoLengthStock>> fetchAllMemos(userId) {
    final usersMemoLengthStock = db.collection('users/$userId/memoLengthStock');
    final allMemoList = usersMemoLengthStock.get().then((docList) {
      List<MemoLengthStock> dataList = docList.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        final firestoreMemoLengthStock =
            FirestoreMemoLengthStock.fromJson(data);
        return firestoreMemoLengthStock.transferMemoLengthStock();
      }).toList();
      return dataList;
    });
    return allMemoList;
  }

  @override
  Future<List<Memo>> fetchBookMemos({
    required String userId,
    required String bookId,
  }) async {
    final usersBookMemos = usersBooks(userId).doc(bookId).collection('memos');
    final memoList = usersBookMemos.get().then((docList) {
      List<Memo> dataList = docList.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        final firestoreMemo = FirestoreMemo.fromJson(data);
        return firestoreMemo.transferToMemo();
      }).toList();
      return dataList;
    });
    return memoList;
  }

  @override
  Future<void> addMemo({
    required String userId,
    required Memo memo,
  }) async {
    final memoRef =
        usersBooks(userId).doc(memo.bookId).collection('memos').doc();

    final sendMemoTextList =
        memo.contents.map((memoText) => memoText.toJson()).toList();

    await memoRef.set({
      'id': memoRef.id,
      'contents': sendMemoTextList,
      'bookId': memo.bookId,
      'startPage': memo.startPage,
      'endPage': memo.endPage,
      'createdAt': FieldValue.serverTimestamp(),
    });

    final totalMemoCount = memo.contents.fold(
        0, (previousValue, element) => previousValue + element.text.length);
    final bookRef = usersBooks(userId).doc(memo.bookId);
    await bookRef.update({
      'totalMemoCount': FieldValue.increment(totalMemoCount),
    });
  }

  @override
  Future<void> removeMemo({required String userId, required Memo memo}) async {
    final memoRef =
        usersBooks(userId).doc(memo.bookId).collection('memos').doc(memo.id);

    await memoRef.delete();
  }

  @override
  Future<void> stockMemoLength({
    required String userId,
    required int addedMemoLength,
    required DateTime date,
  }) async {
    final usersMemoLengthStock = db.collection('users/$userId/memoLengthStock');
    final settingDateText = formatDateToStringWithHyphen(date);
    final docRef = usersMemoLengthStock.doc(settingDateText);

    final memoLengthDoc = await docRef.get();
    final int stockedMemoLength = memoLengthDoc.data()?['memoLength'] ?? 0;

    await docRef.set(
      {
        'date': formatDateToYMD(date),
        'memoLength': stockedMemoLength + addedMemoLength,
      },
      SetOptions(merge: true),
    );
  }
}
