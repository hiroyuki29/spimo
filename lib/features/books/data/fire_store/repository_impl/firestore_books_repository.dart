import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spimo/features/books/domain/model/book.dart';
import 'package:spimo/features/books/domain/repository/book_storage_repository.dart';

class FirestoreBooksRepository implements BookStorageRepository {
  FirestoreBooksRepository({required this.userId});

  FirebaseFirestore db = FirebaseFirestore.instance;
  final String userId;

  @override
  Future<List<Book>> fetchBooks() async {
    final usersBooks = db.collection('users').doc(userId).collection('books');
    final bookList = usersBooks.get().then((docList) {
      final dataList = docList.docs.map((doc) {
        final data = doc.data();
        return Book.fromJson(data);
      }).toList();
      return dataList;
    });
    return bookList;
  }

  @override
  Future<void> addBook(Book book) async {
    final usersBooks = db.collection('users').doc(userId).collection('books');
    final newDocId = usersBooks.doc().id;
    usersBooks.doc(newDocId).set(
      {
        'id': newDocId,
        'title': book.title,
        'authors': book.authors,
        'imageLinks': book.imageLinks,
        'pageCount': book.pageCount,
        'createdAt': FieldValue.serverTimestamp(),
      },
    );
  }

  @override
  Future<void> removeBook(Book book) async {
    final usersBooks = db.collection('users').doc(userId).collection('books');
    usersBooks.doc(book.id).delete();
  }
}
