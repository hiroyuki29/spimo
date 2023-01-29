import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spimo/common_widget/app_bar/common_app_bar.dart';
import 'package:spimo/common_widget/async_value/async_value_widget.dart';
import 'package:spimo/common_widget/color/color.dart';
import 'package:spimo/common_widget/indicator/loading_circle_indicator.dart';
import 'package:spimo/common_widget/sized_box/constant_sized_box.dart';
import 'package:spimo/features/books/presentation/controller/current_book_controller.dart';
import 'package:spimo/features/books/presentation/ui_compornent/book_list_tile.dart';
import 'package:spimo/features/home/presentation/controller/home_controller.dart';
import 'package:spimo/features/home/presentation/ui_compornent/chart_rage_chip.dart';

enum ChartAverageRange {
  one(1),
  five(5),
  ten(10),
  twenty(20);

  const ChartAverageRange(this.number);

  final int number;
}

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  ChartAverageRange chartAvarageRange = ChartAverageRange.five;

  Future<void> setChartAverageRage() async {
    ref
        .read(homeMemoChartControllerProvider.notifier)
        .getChartPoints(averageRange: chartAvarageRange.number);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(homeMemoSumWordsControllerProvider.notifier)
          .getAllMemoWordLength();
      ref
          .read(homeMemoChartControllerProvider.notifier)
          .getChartPoints(averageRange: ChartAverageRange.five.number);
    });
    //
  }

  @override
  Widget build(BuildContext context) {
    final sumAllMemoWors = ref.watch(homeMemoSumWordsControllerProvider);
    final chartPoints = ref.watch(homeMemoChartControllerProvider);
    final currentBook = ref.watch(currentBookControllerProvider);
    return Scaffold(
      backgroundColor: backgroundGray,
      appBar: CommonAppBar(context: context, title: 'home'),
      body: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  currentBook == null
                      ? const LoadingCircleIndicator()
                      : Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: BookListTile(
                            book: currentBook,
                          ),
                        ),
                  AsyncValueWidget(
                      value: sumAllMemoWors,
                      data: (data) {
                        return Center(
                            child: Text(
                          '合計のメモ文字数:$data',
                          style: const TextStyle(
                            color: black,
                            fontSize: 20,
                          ),
                        ));
                      }),
                  sizedBoxH24,
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'メモ分布',
                            style: TextStyle(
                              color: Color(0xff827daa),
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ChartRageChip(
                                title: '1',
                                isActive:
                                    chartAvarageRange == ChartAverageRange.one,
                                onSelected: (_) {
                                  setState(() {
                                    chartAvarageRange = ChartAverageRange.one;
                                  });
                                  setChartAverageRage();
                                },
                              ),
                              ChartRageChip(
                                title: '5',
                                isActive:
                                    chartAvarageRange == ChartAverageRange.five,
                                onSelected: (_) {
                                  setState(() {
                                    chartAvarageRange = ChartAverageRange.five;
                                  });
                                  setChartAverageRage();
                                },
                              ),
                              ChartRageChip(
                                title: '10',
                                isActive:
                                    chartAvarageRange == ChartAverageRange.ten,
                                onSelected: (_) {
                                  setState(() {
                                    chartAvarageRange = ChartAverageRange.ten;
                                  });
                                  setChartAverageRage();
                                },
                              ),
                              ChartRageChip(
                                title: '20',
                                isActive: chartAvarageRange ==
                                    ChartAverageRange.twenty,
                                onSelected: (_) {
                                  setState(() {
                                    chartAvarageRange =
                                        ChartAverageRange.twenty;
                                  });
                                  setChartAverageRage();
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 250,
                            child: AsyncValueWidget(
                              value: chartPoints,
                              data: (data) => Padding(
                                padding: const EdgeInsets.all(16),
                                child: _MemoDistributionChart(
                                  chartPointsAll: data.chartPointsAll,
                                  chartPointsOnlyRed: data.chartPointsOnlyRed,
                                  pageCount: data.pageCount.toDouble(),
                                  maxWordLength: data.maxWordLength,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  sizedBoxH16,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MemoDistributionChart extends StatelessWidget {
  const _MemoDistributionChart({
    required this.chartPointsAll,
    required this.chartPointsOnlyRed,
    required this.pageCount,
    required this.maxWordLength,
  });

  final List<FlSpot> chartPointsAll;
  final List<FlSpot> chartPointsOnlyRed;
  final double pageCount;
  final double maxWordLength;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      sampleData1,
      swapAnimationDuration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 0,
        maxX: pageCount,
        minY: 0,
        maxY: maxWordLength,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
        lineChartBarData1_2,
        // lineChartBarData1_3,
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: primaryDark,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    final int base = (maxWordLength / 5).floor();

    String text;

    if (value.toInt() == 0) {
      text = '0';
    } else if (value.toInt() == base) {
      text = '$base';
    } else if (value.toInt() == base * 2) {
      text = '${base * 2}';
    } else if (value.toInt() == base * 3) {
      text = '${base * 3}';
    } else if (value.toInt() == base * 4) {
      text = '${base * 4}';
    } else if (value.toInt() == base * 5) {
      text = '${base * 5}';
    } else {
      text = '';
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: primaryDark,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    final int base = (pageCount / 5).floor();

    String text;

    if (value.toInt() == 0) {
      text = '0';
    } else if (value.toInt() == base) {
      text = '$base';
    } else if (value.toInt() == base * 2) {
      text = '${base * 2}';
    } else if (value.toInt() == base * 3) {
      text = '${base * 3}';
    } else if (value.toInt() == base * 4) {
      text = '${base * 4}';
    } else if (value.toInt() == base * 5) {
      text = '${base * 5}';
    } else {
      text = '';
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Text(
        text,
        style: style,
      ),
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Color(0xff4e4965), width: 1),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
      isCurved: false,
      isStepLineChart: true,
      color: primary,
      barWidth: 1,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          colors: [
            primary.withOpacity(0.3),
            Colors.transparent,
          ],
          stops: const [
            0.0,
            1.0,
          ],
        ),
      ),
      spots: chartPointsAll);

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
        isCurved: false,
        isStepLineChart: true,
        color: Colors.red.withOpacity(0.2),
        barWidth: 0,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [
              Colors.red.withOpacity(0.8),
              Colors.red.withOpacity(0.3),
            ],
            stops: const [
              0.0,
              1.0,
            ],
          ),
        ),
        spots: chartPointsOnlyRed,
      );
}
