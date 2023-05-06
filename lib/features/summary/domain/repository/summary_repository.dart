import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spimo/features/summary/data/repository_impl/open_ai_summary_repository.dart';

final summaryRepositoryProvider =
    Provider.autoDispose<SummaryRepository>((ref) {
  return OpenAISummaryRepository();
});

abstract class SummaryRepository {
  Future<String> createSummary({required List<String> memoList});
}
