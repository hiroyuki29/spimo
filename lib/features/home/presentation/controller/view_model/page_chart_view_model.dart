import 'package:fl_chart/fl_chart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'page_chart_view_model.freezed.dart';

@freezed
class PageChartViewModel with _$PageChartViewModel {
  const factory PageChartViewModel({
    required List<FlSpot> chartPoints,
    required int pageCount,
    required double maxWordLength,
  }) = _PageChartViewModel;
}
