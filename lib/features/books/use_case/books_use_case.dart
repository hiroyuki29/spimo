import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spimo/features/books/domain/model/book.dart';
import 'package:spimo/features/books/domain/repository/book_storage_repository.dart';
import 'package:spimo/features/memos/domain/model/memo.dart';
import 'package:spimo/features/memos/domain/repository/memo_storage_repository.dart';

final booksUseCaseProvider = Provider.autoDispose<BooksUseCase>((ref) {
  return BooksUseCase(
      bookStorageRepository: ref.watch(bookStorageProvider),
      memoStorageRepository: ref.watch(memoStorageProvider));
});

class BooksUseCase {
  BooksUseCase({
    required this.bookStorageRepository,
    required this.memoStorageRepository,
  });

  final BookStorageRepository bookStorageRepository;
  final MemoStorageRepository memoStorageRepository;

  Future<Book?> fetchBook({
    required String userId,
    required String bookId,
  }) async {
    Book? book = await bookStorageRepository.fetchBook(
      userId: userId,
      bookId: bookId,
    );
    return book;
  }

  Future<void> addMemo({required String userId, required Memo memo}) async {
    await memoStorageRepository.addMemo(userId: userId, memo: memo);

    await memoStorageRepository.stockMemoLength(
        userId: userId,
        addedMemoLength: memo.memoTextLength,
        date: DateTime.now());
  }

  Future<void> removeMemo({required String userId, required Memo memo}) async {
    await memoStorageRepository.removeMemo(userId: userId, memo: memo);
  }
}
