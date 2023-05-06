import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spimo/features/books/domain/model/book.dart';
import 'package:spimo/features/books/domain/repository/book_storage_repository.dart';
import 'package:spimo/features/memos/domain/model/memo.dart';
import 'package:spimo/features/memos/domain/repository/memo_storage_repository.dart';
import 'package:spimo/features/summary/domain/model/summary.dart';

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

    if (book == null) return null;

    //memoListはそのままではunmodifiableなのでソートできるようにリストを作り直している
    List<Memo> sortedMemoList = List.from(book.memoList);
    sortedMemoList.sort(((a, b) {
      int result = a.startPage.compareTo(b.startPage);
      if (result != 0) return result;
      if (b.isTitle) return 1;
      return -1;
    }));

    //memoListはそのままではunmodifiableなのでソートできるようにリストを作り直している
    List<Summary> sortedSummaryList = List.from(book.summaryList);
    sortedSummaryList.sort(((a, b) => a.startPage.compareTo(b.startPage)));

    final sortedBook =
        book.copyWith(memoList: sortedMemoList, summaryList: sortedSummaryList);
    return sortedBook;
  }
}
