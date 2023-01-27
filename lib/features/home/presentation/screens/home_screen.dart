import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spimo/common_widget/app_bar/common_app_bar.dart';
import 'package:spimo/common_widget/async_value/async_value_widget.dart';
import 'package:spimo/common_widget/indicator/loading_circle_indicator.dart';
import 'package:spimo/features/books/presentation/controller/current_book_controller.dart';
import 'package:spimo/features/books/presentation/ui_compornent/book_list_tile.dart';
import 'package:spimo/features/home/presentation/controller/home_controller.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CommonAppBar(context: context, title: 'home'),
//       body: const SafeArea(
//         child: Text('home'),
//       ),
//     );
//   }
// }

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int avarageRange = 5;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(homeMemoSumWordsControllerProvider.notifier)
          .getAllMemoWordLength();
      ref
          .read(homeMemoChartControllerProvider.notifier)
          .getChartPoints(averageRange: avarageRange);
    });
    //
  }

  @override
  Widget build(BuildContext context) {
    final sumAllMemoWors = ref.watch(homeMemoSumWordsControllerProvider);
    final chartPoints = ref.watch(homeMemoChartControllerProvider);
    final currentBook = ref.watch(currentBookControllerProvider);
    return Scaffold(
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
                      : BookListTile(book: currentBook),
                  AsyncValueWidget(
                      value: sumAllMemoWors,
                      data: (data) {
                        return Text('合計のメモ文字数:$data');
                      }),
                  const SizedBox(
                    height: 37,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 200,
                        child: TextFormField(
                          initialValue: avarageRange.toString(),
                          decoration: const InputDecoration(
                            labelText: '区間（ページ数）',
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              avarageRange = int.tryParse(value) ?? 1;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 100,
                        child: ElevatedButton(
                          onPressed: () async {
                            ref
                                .read(homeMemoChartControllerProvider.notifier)
                                .getChartPoints(averageRange: avarageRange);
                          },
                          child: const Text('保存'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'メモ分布',
                    style: TextStyle(
                      color: Color(0xff827daa),
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 200,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16, left: 6),
                      child: AsyncValueWidget(
                          value: chartPoints,
                          data: (data) => _MemoDistributionChart(
                                chartPoints: data.chartPoints,
                                pageCount: data.pageCount.toDouble(),
                                maxWordLength: data.maxWordLength,
                              )),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
    required this.chartPoints,
    required this.pageCount,
    required this.maxWordLength,
  });

  final List<FlSpot> chartPoints;
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
        // lineChartBarData1_2,
        // lineChartBarData1_3,
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff75729e),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    final int base = (maxWordLength / 5).floor();

    String text;

    if (value.toInt() == base) {
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
      color: Color(0xff72719b),
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );

    final int base = (pageCount / 5).floor();

    String text;

    if (value.toInt() == base) {
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
          bottom: BorderSide(color: Color(0xff4e4965), width: 4),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
      isCurved: false,
      color: Colors.blueAccent,
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(show: true),
      belowBarData: BarAreaData(show: false),
      spots: chartPoints
      // const [
      //   FlSpot(1, 1),
      //   FlSpot(3, 1.5),
      //   FlSpot(5, 1.4),
      //   FlSpot(7, 3.4),
      //   FlSpot(10, 2),
      //   FlSpot(12, 2.2),
      //   FlSpot(13, 1.8),
      // ],
      );

  // LineChartBarData get lineChartBarData1_2 => LineChartBarData(
  //       isCurved: true,
  //       color: const Color(0xffaa4cfc),
  //       barWidth: 8,
  //       isStrokeCapRound: true,
  //       dotData: FlDotData(show: false),
  //       belowBarData: BarAreaData(
  //         show: false,
  //         color: const Color(0x00aa4cfc),
  //       ),
  //       spots: const [
  //         FlSpot(1, 1),
  //         FlSpot(3, 2.8),
  //         FlSpot(7, 1.2),
  //         FlSpot(10, 2.8),
  //         FlSpot(12, 2.6),
  //         FlSpot(13, 3.9),
  //       ],
  //     );

  // LineChartBarData get lineChartBarData1_3 => LineChartBarData(
  //       isCurved: true,
  //       color: const Color(0xff27b6fc),
  //       barWidth: 8,
  //       isStrokeCapRound: true,
  //       dotData: FlDotData(show: false),
  //       belowBarData: BarAreaData(show: false),
  //       spots: const [
  //         FlSpot(1, 2.8),
  //         FlSpot(3, 1.9),
  //         FlSpot(6, 3),
  //         FlSpot(10, 1.3),
  //         FlSpot(13, 2.5),
  //       ],
  //     );
}
