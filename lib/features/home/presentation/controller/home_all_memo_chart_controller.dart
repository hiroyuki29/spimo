import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spimo/features/books/domain/model/book.dart';
import 'package:spimo/features/books/presentation/controller/current_book_controller.dart';
import 'package:spimo/features/home/presentation/controller/view_model/date_chart_viewmodel.dart';
import 'package:spimo/features/home/use_case/home_use_case.dart';

final homeAllMemoChartControllerProvider = StateNotifierProvider<
    HomeAllMemoChartController, AsyncValue<DateChartViewModel>>((ref) {
  return HomeAllMemoChartController(
      homeUseCase: ref.watch(homeUseCaseProvider),
      currentBook: ref.watch(currentBookControllerProvider));
});

class HomeAllMemoChartController
    extends StateNotifier<AsyncValue<DateChartViewModel>> {
  HomeAllMemoChartController(
      {required this.homeUseCase, required this.currentBook})
      : super(const AsyncLoading()) {
    if (currentBook != null) {
      getChartPoints();
    }
  }

  final HomeUseCase homeUseCase;
  Book? currentBook;

  Future<void> getChartPoints() async {
    state = const AsyncLoading();
    if (currentBook != null) {
      List<FlSpot> chartPoints = await homeUseCase.createAllMemoChartPoints();
      double maxWordLength = chartPoints.last.y;
      double allDaysDuration = chartPoints.last.x;
      state = AsyncData(
        DateChartViewModel(
          chartPointsAll: chartPoints,
          allDaysDuration: allDaysDuration,
          maxWordLength: maxWordLength,
        ),
      );
    }
  }
}