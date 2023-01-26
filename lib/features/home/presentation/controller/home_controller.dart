import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spimo/features/books/domain/model/book.dart';
import 'package:spimo/features/books/presentation/controller/current_book_controller.dart';
import 'package:spimo/features/home/use_case/home_use_case.dart';

final homeMemoChartControllerProvider =
    StateNotifierProvider<HomeMemoChartController, AsyncValue<List<FlSpot>>>(
        (ref) {
  return HomeMemoChartController(
      homeUseCase: ref.watch(homeUseCaseProvider),
      currentBook: ref.watch(currentBookControllerProvider));
});

class HomeMemoChartController extends StateNotifier<AsyncValue<List<FlSpot>>> {
  HomeMemoChartController(
      {required this.homeUseCase, required this.currentBook})
      : super(const AsyncData([])) {
    if (currentBook != null) {
      getChartPoints();
    }
  }

  final HomeUseCase homeUseCase;
  Book? currentBook;

  Future<void> getChartPoints() async {
    state = const AsyncLoading();
    if (currentBook != null) {
      state =
          AsyncData(await homeUseCase.createMemoChartPoints(currentBook!.id));
    }
  }
}

final homeMemoSumWordsControllerProvider =
    StateNotifierProvider<HomeMemoSumWordsController, AsyncValue<int?>>((ref) {
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
