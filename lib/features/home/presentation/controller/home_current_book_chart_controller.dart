import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spimo/features/account/presentation/controller/user_controller.dart';
import 'package:spimo/features/books/domain/model/book.dart';
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
    userId: ref.watch(userControllerProvider)!.id,
  );
});

class HomeCurrentBookChartController
    extends StateNotifier<AsyncValue<PageChartViewModel>> {
  HomeCurrentBookChartController({
    required this.homeUseCase,
    required this.userId,
  }) : super(const AsyncLoading());

  final HomeUseCase homeUseCase;
  final String userId;

  Future<void> getChartPoints(
      {required int averageRange, required Book currentBook}) async {
    state = const AsyncLoading();
    List<List<FlSpot>> chartPoints =
        await homeUseCase.createCurrentBookMemoChartPoints(
      userId: userId,
      bookId: currentBook.id,
      averageRange: averageRange,
    );
    double maxWordLength = homeUseCase.getMaxWordLength(chartPoints[0]);
    state = AsyncData(
      PageChartViewModel(
        chartPointsAll: chartPoints[0],
        chartPointsOnlyRed: chartPoints[1],
        pageCount: currentBook.pageCount!,
        maxWordLength: maxWordLength,
      ),
    );
  }
}
