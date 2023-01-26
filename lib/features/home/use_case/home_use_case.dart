import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spimo/features/memos/domain/model/memo.dart';
import 'package:spimo/features/memos/domain/model/memo_text.dart';
import 'package:spimo/features/memos/domain/repository/memo_storage_repository.dart';

final homeUseCaseProvider = Provider<HomeUseCase>((ref) {
  return HomeUseCase(
    memoStorageRepository: ref.watch(memoStorageProvider),
  );
});

class HomeUseCase {
  HomeUseCase({required this.memoStorageRepository});
  final MemoStorageRepository memoStorageRepository;

  Future<List<FlSpot>> createMemoChartPoints(String bookId) async {
    final memos = await memoStorageRepository.fetchBookMemos(bookId);
    List<Memo> memosWithoutNullOfStartPage =
        memos.where((memo) => memo.startPage != null).toList();
    memosWithoutNullOfStartPage
        .sort(((a, b) => a.startPage!.compareTo(b.startPage!)));
    Map<int, dynamic> wordAndPageMap = {};
    double wordLengthEachMemo = 0;
    for (Memo memo in memosWithoutNullOfStartPage) {
      if (memo.startPage == null) {
        continue;
      }
      wordLengthEachMemo = 0;
      for (MemoText memoText in memo.contents) {
        wordLengthEachMemo += memoText.text.length;
      }
      wordAndPageMap[memo.startPage!] = wordLengthEachMemo;
    }
    List<FlSpot> chartPoints = [];
    for (final entry in wordAndPageMap.entries) {
      chartPoints.add(FlSpot(entry.key.toDouble(), entry.value));
    }
    return chartPoints;
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
}
