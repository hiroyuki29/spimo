import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spimo/features/books/domain/model/book.dart';
import 'package:spimo/features/books/presentation/controller/current_book_controller.dart';
import 'package:spimo/features/home/presentation/controller/view_model/page_chart_view_model.dart';
import 'package:spimo/features/home/use_case/home_use_case.dart';

enum ChartAverageRange {
  one(1),
  five(5),
  ten(10),
  twenty(20);

  const ChartAverageRange(this.number);

  final int number;
}

final homeCurrentBookChartControllerProvider =
    StateNotifierProvider.autoDispose<HomeCurrentBookChartController,
        AsyncValue<PageChartViewModel>>((ref) {
  return HomeCurrentBookChartController(
      homeUseCase: ref.watch(homeUseCaseProvider),
      currentBook: ref.watch(currentBookControllerProvider));
});

class HomeCurrentBookChartController
    extends StateNotifier<AsyncValue<PageChartViewModel>> {
  HomeCurrentBookChartController(
      {required this.homeUseCase, required this.currentBook})
      : super(const AsyncLoading()) {
    if (currentBook != null) {
      getChartPoints(averageRange: ChartAverageRange.five.number);
    }
  }

  final HomeUseCase homeUseCase;
  Book? currentBook;

  Future<void> getChartPoints({required int averageRange}) async {
    state = const AsyncLoading();
    if (currentBook != null) {
      List<List<FlSpot>> chartPoints =
          await homeUseCase.createCurrentBookMemoChartPoints(
              bookId: currentBook!.id, averageRange: averageRange);
      double maxWordLength = homeUseCase.getMaxWordLength(chartPoints[0]);
      state = AsyncData(
        PageChartViewModel(
          chartPointsAll: chartPoints[0],
          chartPointsOnlyRed: chartPoints[1],
          pageCount: currentBook!.pageCount!,
          maxWordLength: maxWordLength,
        ),
      );
    }
  }
}

final homeMemoSumWordsControllerProvider = StateNotifierProvider.autoDispose<
    HomeMemoSumWordsController, AsyncValue<int?>>((ref) {
  return HomeMemoSumWordsController(
      homeUseCase: ref.watch(homeUseCaseProvider),
      currentBook: ref.watch(currentBookControllerProvider));
});

class HomeMemoSumWordsController extends StateNotifier<AsyncValue<int?>> {
  HomeMemoSumWordsController(
      {required this.homeUseCase, required this.currentBook})
      : super(const AsyncData(null)) {
    if (currentBook != null) {
      getAllMemoWordLength();
    }
  }

  final HomeUseCase homeUseCase;
  Book? currentBook;

  Future<void> getAllMemoWordLength() async {
    state = const AsyncLoading();
    if (currentBook != null) {
      state = AsyncData(await homeUseCase.sumMemoWordLength(currentBook!.id));
    }
  }
}
