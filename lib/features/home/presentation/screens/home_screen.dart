import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spimo/common_method/datetime_formatter.dart';
import 'package:spimo/common_widget/app_bar/common_app_bar.dart';
import 'package:spimo/common_widget/async_value/async_value_widget.dart';
import 'package:spimo/common_widget/color/color.dart';
import 'package:spimo/common_widget/indicator/loading_circle_indicator.dart';
import 'package:spimo/common_widget/sized_box/constant_sized_box.dart';
import 'package:spimo/features/books/domain/model/book.dart';
import 'package:spimo/features/books/presentation/controller/current_book_controller.dart';
import 'package:spimo/features/books/presentation/ui_compornent/book_list_tile.dart';
import 'package:spimo/features/home/presentation/controller/home_all_memo_chart_controller.dart';
import 'package:spimo/features/home/presentation/controller/home_current_book_chart_controller.dart';
import 'package:spimo/features/home/presentation/ui_compornent/chart_rage_chip.dart';

class HomeScreen extends StatefulHookConsumerWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  ChartAverageRange chartAvarageRange = ChartAverageRange.five;

  Future<void> setChartAverageRage(Book currentBook) async {
    ref.read(homeCurrentBookChartControllerProvider.notifier).getChartPoints(
          averageRange: chartAvarageRange.number,
          currentBook: currentBook,
        );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentBookChartPoints =
        ref.watch(homeCurrentBookChartControllerProvider);
    final currentBook = ref.watch(currentBookControllerProvider);
    final allMemoChartPoints = ref.watch(homeAllMemoChartControllerProvider);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        currentBook.whenData((book) => book == null
            ? null
            : ref
                .read(homeCurrentBookChartControllerProvider.notifier)
                .getChartPoints(
                    averageRange: ChartAverageRange.five.number,
                    currentBook: book));
      });
      return null;
    }, [currentBook]);

    return Scaffold(
      backgroundColor: backgroundGray,
      appBar: CommonAppBar(context: context, title: 'home'),
      body: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              child: AsyncValueWidget(
                value: currentBook,
                data: (book) => book == null
                    ? const Text('no data')
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          HomeContent(
                            title: '現在選択中の本',
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: BookListTile(
                                isSelected: false,
                                book: book,
                                color: white,
                              ),
                            ),
                          ),
                          sizedBoxH24,
                          HomeContent(
                            title: '合計メモ文字数',
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: DecoratedBox(
                                  decoration: const BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Center(
                                          child: Text(
                                        '${book.totalMemoCount}字',
                                        style: const TextStyle(
                                          color: black,
                                          fontSize: 20,
                                        ),
                                      )),
                                    ),
                                  ),
                                )),
                          ),
                          sizedBoxH24,
                          HomeContent(
                            title: '各ページに対するメモ文字数',
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 6),
                              child: DecoratedBox(
                                decoration: const BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    sizedBoxH8,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ChartRageChip(
                                          title: '1',
                                          isActive: chartAvarageRange ==
                                              ChartAverageRange.one,
                                          onSelected: (_) {
                                            setState(() {
                                              chartAvarageRange =
                                                  ChartAverageRange.one;
                                            });
                                            setChartAverageRage(book);
                                          },
                                        ),
                                        ChartRageChip(
                                          title: '5',
                                          isActive: chartAvarageRange ==
                                              ChartAverageRange.five,
                                          onSelected: (_) {
                                            setState(() {
                                              chartAvarageRange =
                                                  ChartAverageRange.five;
                                            });
                                            setChartAverageRage(book);
                                          },
                                        ),
                                        ChartRageChip(
                                          title: '10',
                                          isActive: chartAvarageRange ==
                                              ChartAverageRange.ten,
                                          onSelected: (_) {
                                            setState(() {
                                              chartAvarageRange =
                                                  ChartAverageRange.ten;
                                            });
                                            setChartAverageRage(book);
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
                                            setChartAverageRage(book);
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 250,
                                      child: AsyncValueWidget(
                                        value: currentBookChartPoints,
                                        data: (data) => Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: _MemoDistributionChart(
                                            chartPoints: data.chartPointsAll,
                                            secoundaryChartPoints:
                                                data.chartPointsOnlyRed,
                                            isStepLineChart: true,
                                            maxX: data.pageCount.toDouble(),
                                            maxY: data.maxWordLength,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          sizedBoxH16,
                          HomeContent(
                            title: 'すべてのメモ文字数の遷移',
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 6),
                              child: DecoratedBox(
                                decoration: const BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    sizedBoxH8,
                                    SizedBox(
                                      height: 250,
                                      child: AsyncValueWidget(
                                        value: allMemoChartPoints,
                                        data: (data) => Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: _MemoDistributionChart(
                                            chartPoints: data.chartPointsAll,
                                            maxX:
                                                data.allDaysDuration.toDouble(),
                                            maxY: data.maxWordLength,
                                            isDateChart: true,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.subtitle2,
            textAlign: TextAlign.center,
          ),
        ),
        child,
      ],
    );
  }
}

class _MemoDistributionChart extends StatelessWidget {
  const _MemoDistributionChart({
    required this.chartPoints,
    this.secoundaryChartPoints,
    this.isStepLineChart = false,
    required this.maxX,
    required this.maxY,
    this.isDateChart = false,
  });

  final List<FlSpot> chartPoints;
  final List<FlSpot>? secoundaryChartPoints;
  final bool isStepLineChart;
  final double maxX;
  final double maxY;
  final bool isDateChart;

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
        maxX: maxX,
        minY: 0,
        maxY: maxY,
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
        if (secoundaryChartPoints != null) lineChartBarData1_2,
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: primaryDark,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    final int base = (maxY / 5).floor();

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

    String text;

    if (isDateChart) {
      final now = DateTime.now();
      final startDay = now.subtract(Duration(days: maxX.toInt()));
      final middleDurationDays = (maxX / 2).ceil();
      final middleDay = startDay.add(Duration(days: middleDurationDays));
      if (value.toInt() == 0) {
        text = formatDateToString(startDay);
      } else if (value.toInt() == middleDurationDays) {
        text = formatDateToString(middleDay);
      } else if (value.toInt() == maxX) {
        text = '現在';
      } else {
        text = '';
      }
    } else {
      final int base = (maxX / 5).floor();

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
      isStepLineChart: isStepLineChart,
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
      spots: chartPoints);

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
        isCurved: false,
        isStepLineChart: isStepLineChart,
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
        spots: secoundaryChartPoints,
      );
}
