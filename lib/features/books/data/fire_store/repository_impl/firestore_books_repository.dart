import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spimo/features/books/domain/model/book.dart';
import 'package:spimo/features/books/domain/repository/book_storage_repository.dart';
import 'package:spimo/features/memos/data/fire_store/model/firestore_memo.dart';
import 'package:spimo/features/memos/domain/model/memo.dart';

class FirestoreBooksRepository implements BookStorageRepository {
  FirestoreBooksRepository();

  FirebaseFirestore db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> usersBooks(String userId) {
    return db.collection('users').doc(userId).collection('books');
  }

  @override
  Future<List<Book>> fetchBooks(String userId) async {
    final bookList = usersBooks(userId).get().then((docList) {
      List<Book> dataList = docList.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        return Book.fromJson(data);
      }).toList();
      return dataList;
    });
    return bookList;
  }

  @override
  Future<Book?> fetchBook(
      {required String userId, required String bookId}) async {
    final book = await usersBooks(userId).doc(bookId).get().then((doc) async {
      final data = doc.data();
      if (data == null) {
        return null;
      }
      final book = Book.fromJson(data);

      final memoRef = doc.reference.collection('memos');
      final memoList = await memoRef.get().then((docList) {
        List<Memo> dataList = docList.docs.map((doc) {
          Map<String, dynamic> data = doc.data();
          final firestoreMemo = FirestoreMemo.fromJson(data);
          return firestoreMemo.transferToMemo();
        }).toList();
        return dataList;
      });
      memoList.sort(((a, b) => a.startPage!.compareTo(b.startPage!)));
      return book.copyWith(memoList: memoList);
    });
    return book;
  }

  @override
  Future<void> setCurrentBookId(
      {required String userId, required String bookId}) async {
    await db.collection('users').doc(userId).update({'currentBookId': bookId});
  }

  @override
  Future<void> resetCurrentBookId({required String userId}) async {
    await db.collection('users').doc(userId).update({'currentBookId': ''});
  }

  @override
  Future<void> addBook({required String userId, required Book book}) async {
    final newDocId = usersBooks(userId).doc().id;
    await usersBooks(userId).doc(newDocId).set(
      {
        'id': newDocId,
        'title': book.title,
        'authors': book.authors,
        'imageLinks': book.imageLinks,
        'pageCount': book.pageCount,
        'createdAt': FieldValue.serverTimestamp(),
        'totalMemoCount': 0,
      },
    );
  }

  @override
  Future<void> removeBook({required String userId, required Book book}) async {
    await usersBooks(userId).doc(book.id).delete();
  }
}
