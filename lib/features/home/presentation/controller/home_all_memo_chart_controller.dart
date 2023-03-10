import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spimo/features/account/presentation/controller/user_controller.dart';
import 'package:spimo/features/home/presentation/controller/view_model/date_chart_viewmodel.dart';
import 'package:spimo/features/home/use_case/home_use_case.dart';

final homeAllMemoChartControllerProvider = StateNotifierProvider.autoDispose<
    HomeAllMemoChartController, AsyncValue<DateChartViewModel?>>((ref) {
  return HomeAllMemoChartController(
    homeUseCase: ref.watch(homeUseCaseProvider),
    userId: ref.watch(userControllerProvider)!.id,
  );
});

class HomeAllMemoChartController
    extends StateNotifier<AsyncValue<DateChartViewModel?>> {
  HomeAllMemoChartController({
    required this.homeUseCase,
    required this.userId,
  }) : super(const AsyncData(null)) {
    getChartPoints();
  }

  final HomeUseCase homeUseCase;
  // final Book? currentBook;
  final String userId;

  Future<void> getChartPoints() async {
    state = const AsyncLoading();

    Map<int, double> chartPoints =
        await homeUseCase.createAllMemoChartPoints(userId);
    if (chartPoints.isEmpty) {
      state = const AsyncData(null);
      return;
    }
    double maxWordLength = chartPoints.values.last;
    double allDaysDuration = chartPoints.keys.last.toDouble();

    final List<FlSpot> graphPointsAll = chartPoints.entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value);
    }).toList();

    state = AsyncData(
      DateChartViewModel(
        chartPointsAll: graphPointsAll,
        allDaysDuration: allDaysDuration,
        maxWordLength: maxWordLength,
      ),
    );
  }
}
