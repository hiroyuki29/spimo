import 'package:fl_chart/fl_chart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'date_chart_viewmodel.freezed.dart';

@freezed
class DateChartViewModel with _$DateChartViewModel {
  const factory DateChartViewModel({
    required List<FlSpot> chartPointsAll,
    required double allDaysDuration,
    required double maxWordLength,
  }) = _DateChartViewModel;
}
