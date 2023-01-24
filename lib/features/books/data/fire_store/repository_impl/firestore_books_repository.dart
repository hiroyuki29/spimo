import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spimo/features/books/domain/model/book.dart';
import 'package:spimo/features/books/domain/repository/book_storage_repository.dart';

class FirestoreBooksRepository implements BookStorageRepository {
  FirestoreBooksRepository({required this.userId});

  FirebaseFirestore db = FirebaseFirestore.instance;
  final String userId;

  CollectionReference<Map<String, dynamic>> get usersBooks =>
      db.collection('users').doc(userId).collection('books');

  @override
  Future<List<Book>> fetchBooks() async {
    final bookList = usersBooks.get().then((docList) {
      List<Book> dataList = docList.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        return Book.fromJson(data);
      }).toList();
      return dataList;
    });
    return bookList;
  }

  @override
  Future<Book> fetchBook(String bookId) {
    final book = usersBooks.doc(bookId).get().then((doc) {
      final data = doc.data();
      return Book.fromJson(data!);
    });
    return book;
  }

  @override
  Future<void> addBook(Book book) async {
    final newDocId = usersBooks.doc().id;
    await usersBooks.doc(newDocId).set(
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
    await usersBooks.doc(book.id).delete();
  }
}
