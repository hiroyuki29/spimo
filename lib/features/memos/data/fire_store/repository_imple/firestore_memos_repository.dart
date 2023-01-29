import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spimo/features/memos/domain/model/memo.dart';
import 'package:spimo/features/memos/domain/repository/memo_storage_repository.dart';

class FireStoreMemosRepository implements MemoStorageRepository {
  FireStoreMemosRepository({required this.userId});

  FirebaseFirestore db = FirebaseFirestore.instance;
  final String userId;

  CollectionReference<Map<String, dynamic>> get usersBooks =>
      db.collection('users').doc(userId).collection('books');

  @override
  Future<List<Memo>> fetchAllMemos() {
    final allMemoList = db.collectionGroup('memos').get().then((docList) {
      List<Memo> dataList = docList.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        return Memo.fromJson(data);
      }).toList();
      return dataList;
    });
    return allMemoList;
  }

  @override
  Future<List<Memo>> fetchBookMemos(String bookId) async {
    final usersBookMemos = usersBooks.doc(bookId).collection('memos');
    final memoList = usersBookMemos.get().then((docList) {
      List<Memo> dataList = docList.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        return Memo.fromJson(data);
      }).toList();
      return dataList;
    });
    return memoList;
  }

  @override
  Future<void> addMemo(Memo memo) async {
    final usersBookMemos = usersBooks.doc(memo.bookId).collection('memos');
    final newDocId = usersBookMemos.doc().id;
    final sendMemoTextList = memo.contents.map(
      (memoText) {
        return memoText.toJson();
      },
    ).toList();
    await usersBookMemos.doc(newDocId).set(
      {
        'id': newDocId,
        'contents': sendMemoTextList,
        'bookId': memo.bookId,
        'startPage': memo.startPage,
        'endPage': memo.endPage,
        'createdAt': FieldValue.serverTimestamp(),
      },
    );
  }

  @override
  Future<void> removeMemo(Memo memo) async {
    await usersBooks.doc(memo.bookId).collection('memos').doc(memo.id).delete();
  }
}
