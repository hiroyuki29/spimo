import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spimo/features/books/domain/model/book.dart';
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
    // TODO: implement fetchAllMemos
    throw UnimplementedError();
  }

  @override
  Future<List<Memo>> fetchBookMemos(Book book) async {
    final usersBookMemos = usersBooks.doc(book.id).collection('memos');
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
  Future<void> removeMemo(Memo memo) {
    // TODO: implement removeMemo
    throw UnimplementedError();
  }
}
