import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spimo/features/books/domain/model/book.dart';
import 'package:spimo/features/memos/domain/repository/memo_storage_repository.dart';
import 'package:spimo/features/summary/domain/model/summary.dart';
import 'package:spimo/features/summary/domain/repository/summary_repository.dart';

final summaryUseCaseProvider = Provider.autoDispose<SummaryUseCase>((ref) {
  return SummaryUseCase(
    summaryRepository: ref.watch(summaryRepositoryProvider),
    memoStorageRepository: ref.watch(memoStorageProvider),
  );
});

class SummaryUseCase {
  SummaryUseCase({
    required this.summaryRepository,
    required this.memoStorageRepository,
  });

  final SummaryRepository summaryRepository;
  final MemoStorageRepository memoStorageRepository;

  Future<String> createSummary({
    required Book book,
    required int startPage,
    required int endPage,
  }) async {
    final memoList = book.memoList
        .where(
          (memo) =>
              memo.startPage != null &&
              memo.startPage! >= startPage &&
              memo.startPage! <= endPage,
        )
        .expand((memo) => memo.contents.map((e) => '${e.text}。'))
        .toList();

    final summary = await summaryRepository.createSummary(memoList: memoList);
    return summary.trim();
  }

  Future<void> addSummary(
      {required String userId, required Summary summary}) async {
    await memoStorageRepository.addSummary(userId: userId, summary: summary);
  }

  Future<void> removeSummary(
      {required String userId, required Summary summary}) async {
    await memoStorageRepository.removeSummary(userId: userId, summary: summary);
  }
}
