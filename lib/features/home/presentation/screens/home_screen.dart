import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spimo/common_method/datetime_formatter.dart';
import 'package:spimo/common_widget/app_bar/common_app_bar.dart';
import 'package:spimo/common_widget/async_value/async_value_widget.dart';
import 'package:spimo/common_widget/color/color.dart';
import 'package:spimo/common_widget/sized_box/constant_sized_box.dart';
import 'package:spimo/features/books/domain/model/book.dart';
import 'package:spimo/features/books/presentation/controller/books_controller.dart';
import 'package:spimo/features/books/presentation/controller/current_book_controller.dart';
import 'package:spimo/features/books/presentation/ui_compornent/book_list_tile.dart';
import 'package:spimo/features/home/presentation/controller/home_all_memo_chart_controller.dart';
import 'package:spimo/features/home/presentation/controller/home_current_book_chart_controller.dart';
import 'package:spimo/features/home/presentation/ui_compornent/chart_rage_chip.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(initialLength: 2);

    List<Widget> tabs = [
      const Tab(
        child: Text(
          'currentBook',
          style: TextStyle(color: primaryDark),
        ),
      ),
      const Tab(
        child: Text(
          'all',
          style: TextStyle(color: primaryDark),
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: backgroundGray,
      appBar: CommonAppBar(
        context: context,
        title: 'home',
        bottom: TabBar(
          controller: tabController,
          indicatorColor: primaryDark,
          indicatorWeight: 3,
          tabs: tabs,
        ),
      ),
      body: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: TabBarView(
              controller: tabController,
              children: const [
                CurrentBookHomeContents(),
                AllMemoHomeContents(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AllMemoHomeContents extends ConsumerWidget {
  const AllMemoHomeContents({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allMemoChartPoints = ref.watch(homeAllMemoChartControllerProvider);

    return Column(
      children: [
        HomeContent(
          title: '全てのメモ文字数の推移',
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: white,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: SizedBox(
                height: 250,
                child: AsyncValueWidget(
                  value: allMemoChartPoints,
                  data: (data) => Padding(
                    padding: const EdgeInsets.all(16),
                    child: _MemoDistributionChart(
                      chartPoints: data.chartPointsAll,
                      maxX: data.allDaysDuration.toDouble(),
                      maxY: data.maxWordLength,
                      isDateChart: true,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        sizedBoxH16,
        const HomeContent(
          title: 'メモランキング',
          child: MemoRanking(),
        ),
      ],
    );
  }
}

class MemoRanking extends HookConsumerWidget {
  const MemoRanking({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final books = ref.watch(sortedBookListProvider);
    const pageViewFraction = 0.7;
    final pageController =
        usePageController(viewportFraction: pageViewFraction);
    final rankingTileWidth =
        MediaQuery.of(context).size.width * pageViewFraction;

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(bookSortTypeProvider.notifier).state = BookSortType.ranking;
      });
      return null;
    }, []);

    return AsyncValueWidget(
      value: books,
      data: (books) => SizedBox(
        height: 150,
        child: PageView.builder(
            padEnds: false,
            controller: pageController,
            itemCount: books.length,
            itemBuilder: ((context, index) {
              final book = books[index];
              return Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MemoRankingTile(
                        rankingTileWidth: rankingTileWidth,
                        book: book,
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: accent),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          child: Text(
                            (index + 1).toString(),
                            style: const TextStyle(color: white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            })),
      ),
    );
  }
}

class MemoRankingTile extends StatelessWidget {
  const MemoRankingTile({
    Key? key,
    required this.rankingTileWidth,
    required this.book,
  }) : super(key: key);

  final double rankingTileWidth;
  final Book book;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: rankingTileWidth - 20,
              child: Text(
                book.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8,
                bottom: 16,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    book.imageLinks ?? '',
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.image_not_supported_outlined,
                      );
                    },
                  ),
                  sizedBoxW16,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'メモ文字数',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        Text(
                          book.totalMemoCount.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
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

class CurrentBookHomeContents extends HookConsumerWidget {
  const CurrentBookHomeContents({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentBookChartPoints =
        ref.watch(homeCurrentBookChartControllerProvider);
    final currentBook = ref.watch(currentBookControllerProvider);
    final chartAvarageRange =
        useState<ChartAverageRange>(ChartAverageRange.five);

    Future<void> setChartAverageRage(Book currentBook) async {
      ref.read(homeCurrentBookChartControllerProvider.notifier).getChartPoints(
            averageRange: chartAvarageRange.value.number,
            currentBook: currentBook,
          );
    }

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

    return SingleChildScrollView(
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
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                                  isActive: chartAvarageRange.value ==
                                      ChartAverageRange.one,
                                  onSelected: (_) {
                                    chartAvarageRange.value =
                                        ChartAverageRange.one;
                                    setChartAverageRage(book);
                                  },
                                ),
                                ChartRageChip(
                                  title: '5',
                                  isActive: chartAvarageRange.value ==
                                      ChartAverageRange.five,
                                  onSelected: (_) {
                                    chartAvarageRange.value =
                                        ChartAverageRange.five;

                                    setChartAverageRage(book);
                                  },
                                ),
                                ChartRageChip(
                                  title: '10',
                                  isActive: chartAvarageRange.value ==
                                      ChartAverageRange.ten,
                                  onSelected: (_) {
                                    chartAvarageRange.value =
                                        ChartAverageRange.ten;

                                    setChartAverageRage(book);
                                  },
                                ),
                                ChartRageChip(
                                  title: '20',
                                  isActive: chartAvarageRange.value ==
                                      ChartAverageRange.twenty,
                                  onSelected: (_) {
                                    chartAvarageRange.value =
                                        ChartAverageRange.twenty;
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
                ],
              ),
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
