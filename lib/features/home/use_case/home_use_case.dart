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
    int memoWordsLength = 0;
    memos.map((memo) {
      memo.contents.map((content) {
        memoWordsLength += content.text.length;
      });
    });
    return [];
  }

  Future<int> sumMemoWordLength(String bookId) async {
    final memos = await memoStorageRepository.fetchBookMemos(bookId);
    int memoWordsLength = 0;
    // memos.map((memo) {
    //   memo.contents.map((content) {
    //     memoWordsLength += content.text.length;
    //   });
    // });
    for (Memo memo in memos) {
      for (MemoText memoText in memo.contents) {
        memoWordsLength += memoText.text.length;
      }
    }
    return memoWordsLength;
  }
}
