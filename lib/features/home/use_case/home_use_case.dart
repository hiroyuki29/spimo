import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spimo/features/books/domain/repository/book_storage_repository.dart';
import 'package:spimo/features/memos/domain/model/memo.dart';
import 'package:spimo/features/memos/domain/model/memo_length_stock.dart';
import 'package:spimo/features/memos/domain/model/memo_text.dart';
import 'package:spimo/features/memos/domain/repository/memo_storage_repository.dart';

final homeUseCaseProvider = Provider.autoDispose<HomeUseCase>((ref) {
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
    required String userId,
    required String bookId,
    required int averageRange,
  }) async {
    final book =
        await bookStorageRepository.fetchBook(userId: userId, bookId: bookId);
    if (book == null || book.pageCount == null || book.pageCount == 0) {
      return [];
    }
    final memos = await memoStorageRepository.fetchBookMemos(
        userId: userId, bookId: bookId);

    if (memos.isEmpty) {
      return [];
    }

    final memosWithStartPage =
        memos.where((memo) => memo.startPage != null).toList();
    memosWithStartPage.sort((a, b) => a.startPage!.compareTo(b.startPage!));

    final wordAndPageMap = Map<int, double>.fromIterable(
      List.generate((book.pageCount! / averageRange).ceil(), (i) => i),
      value: (_) => 0,
    );
    final wordAndPageMapOnlyRed = Map<int, double>.from(wordAndPageMap);

    for (final memo in memosWithStartPage) {
      double wordLength = 0;
      double wordLengthOnlyRed = 0;

      for (final memoText in memo.contents) {
        wordLength += memoText.text.length;
        if (memoText.textColor == TextColor.red) {
          wordLengthOnlyRed += memoText.text.length;
        }
      }

      final page = memo.startPage!;
      final key = (page / averageRange).floor();
      wordAndPageMap.update(
        key,
        (value) => value + wordLength,
        ifAbsent: () => wordLength,
      );

      wordAndPageMapOnlyRed.update(
        key,
        (value) => value + wordLengthOnlyRed,
        ifAbsent: () => wordLengthOnlyRed,
      );
    }

    final chartPointsAll = wordAndPageMap.entries.map((entry) {
      final page = entry.key * averageRange + averageRange / 2;
      return FlSpot(page.toDouble(), entry.value);
    }).toList();

    final chartPointsOnlyRed = wordAndPageMapOnlyRed.entries.map((entry) {
      final page = entry.key * averageRange + averageRange / 2;
      return FlSpot(page.toDouble(), entry.value);
    }).toList();

    final firstAll = FlSpot(0, chartPointsAll.first.y);
    final firstOnlyRed = FlSpot(0, chartPointsOnlyRed.first.y);
    final lastAll = FlSpot(book.pageCount!.toDouble(), chartPointsAll.last.y);
    final lastOnlyRed =
        FlSpot(book.pageCount!.toDouble(), chartPointsOnlyRed.last.y);

    return [
      [firstAll, ...chartPointsAll, lastAll],
      [firstOnlyRed, ...chartPointsOnlyRed, lastOnlyRed],
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

  Future<int> sumMemoWordLength({
    required String userId,
    required String bookId,
  }) async {
    final memos = await memoStorageRepository.fetchBookMemos(
      userId: userId,
      bookId: bookId,
    );
    int memoWordsLength = 0;
    for (Memo memo in memos) {
      for (MemoText memoText in memo.contents) {
        memoWordsLength += memoText.text.length;
      }
    }
    return memoWordsLength;
  }

  Future<List<FlSpot>> createAllMemoChartPoints(String userId) async {
    final memos = await memoStorageRepository.fetchAllMemos(userId);

    memos.sort((a, b) => a.date.compareTo(b.date));

    if (memos.isEmpty) {
      return [];
    }

    final initialDay = memos.first.date;
    final allDuration = DateTime.now().difference(initialDay).inDays;

    final wordAndPageMap = List.filled(allDuration + 1, 0.0);
    double memoLength = 0;
    double sumWordLength = 0;
    DateTime checkingDate = initialDay.subtract(const Duration(days: 1));
    int checkingDuration = 0;

    for (MemoLengthStock memo in memos) {
      int durationDifference = memo.date.difference(checkingDate).inDays;
      memoLength = memo.memoLength.toDouble();
      sumWordLength += memoLength;

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
    for (int i = 0; i < wordAndPageMap.length; i++) {
      chartPointsAll.add(FlSpot(i.toDouble(), wordAndPageMap[i]));
    }
    return chartPointsAll;
  }
}
