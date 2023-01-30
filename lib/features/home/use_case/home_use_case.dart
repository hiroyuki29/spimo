import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spimo/features/books/domain/repository/book_storage_repository.dart';
import 'package:spimo/features/memos/domain/model/memo.dart';
import 'package:spimo/features/memos/domain/model/memo_text.dart';
import 'package:spimo/features/memos/domain/repository/memo_storage_repository.dart';

final homeUseCaseProvider = Provider<HomeUseCase>((ref) {
  return HomeUseCase(
    memoStorageRepository: ref.watch(memoStorageProvider),
    bookStorageRepository: ref.watch(bookStorageProvider),
  );
});

class HomeUseCase {
  HomeUseCase({
    required this.memoStorageRepository,
    required this.bookStorageRepository,
  });
  final MemoStorageRepository memoStorageRepository;
  final BookStorageRepository bookStorageRepository;

  Future<List<List<FlSpot>>> createCurrentBookMemoChartPoints({
    required String bookId,
    required int averageRange,
  }) async {
    final book = await bookStorageRepository.fetchBook(bookId);
    final memos = await memoStorageRepository.fetchBookMemos(bookId);

    List<Memo> memosWithoutNullOfStartPage =
        memos.where((memo) => memo.startPage != null).toList();
    memosWithoutNullOfStartPage
        .sort(((a, b) => a.startPage!.compareTo(b.startPage!)));

    Map<int, dynamic> wordAndPageMap = {};
    double wordLengthEachMemo = 0;

    Map<int, dynamic> wordAndPageMapOnlyRed = {};
    double wordLengthEachMemoOnlyRed = 0;

    for (int i = 0; i * averageRange < book.pageCount!; i++) {
      wordAndPageMap[i] = 0.0;
      wordAndPageMapOnlyRed[i] = 0.0;
    }
    for (Memo memo in memosWithoutNullOfStartPage) {
      if (memo.startPage == null) {
        continue;
      }
      wordLengthEachMemo = 0;
      wordLengthEachMemoOnlyRed = 0;
      for (MemoText memoText in memo.contents) {
        wordLengthEachMemo += memoText.text.length;
        if (memoText.textColor == TextColor.red) {
          wordLengthEachMemoOnlyRed += memoText.text.length;
        }
      }

      wordAndPageMap[(memo.startPage! / averageRange).floor()] +=
          wordLengthEachMemo;

      wordAndPageMapOnlyRed[(memo.startPage! / averageRange).floor()] +=
          wordLengthEachMemoOnlyRed;
    }
    List<FlSpot> chartPointsAll = [];
    for (final entry in wordAndPageMap.entries) {
      chartPointsAll.add(FlSpot(
          (entry.key * averageRange + averageRange / 2).toDouble(),
          entry.value));
    }

    List<FlSpot> chartPointsOnlyRed = [];
    for (final entry in wordAndPageMapOnlyRed.entries) {
      chartPointsOnlyRed.add(FlSpot(
          (entry.key * averageRange + averageRange / 2).toDouble(),
          entry.value));
    }

    chartPointsAll.insert(0, FlSpot(0, chartPointsAll.first.y));
    chartPointsOnlyRed.insert(0, FlSpot(0, chartPointsOnlyRed.first.y));
    chartPointsAll
        .add(FlSpot(book.pageCount!.toDouble(), chartPointsAll.last.y));
    chartPointsOnlyRed
        .add(FlSpot(book.pageCount!.toDouble(), chartPointsOnlyRed.last.y));

    return [
      chartPointsAll,
      chartPointsOnlyRed,
    ];
  }

  double getMaxWordLength(List<FlSpot> chartPoints) {
    double maxWordLength = 0;
    for (FlSpot chartPoint in chartPoints) {
      if (maxWordLength < chartPoint.y) {
        maxWordLength = chartPoint.y;
      }
    }
    return maxWordLength;
  }

  Future<int> sumMemoWordLength(String bookId) async {
    final memos = await memoStorageRepository.fetchBookMemos(bookId);
    int memoWordsLength = 0;
    for (Memo memo in memos) {
      for (MemoText memoText in memo.contents) {
        memoWordsLength += memoText.text.length;
      }
    }
    return memoWordsLength;
  }

  Future<List<FlSpot>> createAllMemoChartPoints() async {
    final memos = await memoStorageRepository.fetchAllMemos();

    memos.sort(((a, b) => a.createdAt.compareTo(b.createdAt)));

    final initialDay = memos.first.createdAt;
    final allDuration = DateTime.now().difference(initialDay).inDays;

    Map<int, dynamic> wordAndPageMap = {};
    double wordLengthEachMemo = 0;
    double sumWordLength = 0;
    DateTime checkingDate = initialDay;
    int checkingDuration = 0;

    for (int i = 0; i <= allDuration; i++) {
      wordAndPageMap[i] = 0.0;
    }

    for (Memo memo in memos) {
      wordLengthEachMemo = 0;
      for (MemoText memoText in memo.contents) {
        wordLengthEachMemo += memoText.text.length;
      }
      sumWordLength += wordLengthEachMemo;

      int durationDifference = memo.createdAt.difference(checkingDate).inDays;

      if (durationDifference != 0) {
        for (int i = 1; i <= durationDifference; i++) {
          wordAndPageMap[checkingDuration] += sumWordLength;
          checkingDate = checkingDate.add(const Duration(days: 1));
          checkingDuration++;
        }
      }
    }
    // 最後の日の加算が上記for文の中でされないため下記で行う
    for (int j = checkingDuration; j <= allDuration; j++) {
      wordAndPageMap[j] += sumWordLength;
    }
    List<FlSpot> chartPointsAll = [];
    for (final entry in wordAndPageMap.entries) {
      chartPointsAll.add(FlSpot(entry.key.toDouble(), entry.value));
    }
    return chartPointsAll;
  }
}
