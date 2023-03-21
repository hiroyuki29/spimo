import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spimo/common_widget/app_bar/common_app_bar.dart';
import 'package:spimo/common_widget/async_value/async_value_widget.dart';
import 'package:spimo/common_widget/color/color.dart';
import 'package:spimo/common_widget/compornent/no_data_display_widget.dart';
import 'package:spimo/common_widget/dialog/custom_alert_dialog.dart';
import 'package:spimo/common_widget/sized_box/constant_sized_box.dart';
import 'package:spimo/features/books/domain/model/book.dart';
import 'package:spimo/features/books/presentation/controller/current_book_controller.dart';
import 'package:spimo/features/books/presentation/ui_compornent/current_book_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:spimo/features/record/presentation/record_home_screen.dart';
import 'package:spimo/features/summary/domain/model/summary.dart';

class SummaryHomeScreen extends HookConsumerWidget {
  const SummaryHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentBook = ref.watch(currentBookControllerProvider);

    return Scaffold(
      backgroundColor: backgroundGray,
      appBar: CommonAppBar(
        context: context,
        title: 'memos',
        action: currentBook.value == null
            ? const SizedBox.shrink()
            : IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    useRootNavigator: true,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25.0)),
                    ),
                    builder: (BuildContext context) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: AddSummaryBottomsheet(
                          currentBook: currentBook.value!,
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(Icons.add),
              ),
      ),
      body: AsyncValueWidget(
        value: currentBook,
        data: (currentBook) => currentBook == null
            ? const NoSelectedBookWidget()
            : Column(
                children: [
                  Container(height: 16, color: backgroundGray),
                  ColoredBox(
                    color: backgroundGray,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: CurrentBookCard(
                        isSelected: false,
                        book: currentBook,
                      ),
                    ),
                  ),
                  Container(height: 16, color: backgroundGray),
                  Expanded(
                    child: currentBook.summaryList.isEmpty
                        ? const NoSavedMemoWidget()
                        : Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: ListView.separated(
                              itemCount: currentBook.summaryList.length,
                              itemBuilder: (context, index) {
                                final summary = currentBook.summaryList[index];
                                return Dismissible(
                                  key: UniqueKey(),
                                  background: Container(
                                    color: Colors.red,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: const [
                                        sizedBoxW24,
                                        Icon(Icons.delete, color: Colors.white),
                                      ],
                                    ),
                                  ),
                                  secondaryBackground: Container(
                                    color: Colors.red,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: const [
                                        Icon(Icons.delete, color: Colors.white),
                                        sizedBoxW24,
                                      ],
                                    ),
                                  ),
                                  confirmDismiss:
                                      (DismissDirection direction) async {
                                    return await showCupertinoDialog(
                                      context: context,
                                      builder: (context) {
                                        return CustomAlertDialog(
                                          title: AppLocalizations.of(context)!
                                              .deleteMemoTitle,
                                          content: AppLocalizations.of(context)!
                                              .deleteMemoContent,
                                          leftText:
                                              AppLocalizations.of(context)!
                                                  .delete,
                                          rightText:
                                              AppLocalizations.of(context)!
                                                  .cancel,
                                          onTapLeft: () {
                                            Navigator.of(context).pop(true);
                                          },
                                          onTapRight: () {
                                            Navigator.of(context).pop(false);
                                          },
                                        );
                                      },
                                    );
                                  },
                                  onDismissed: (DismissDirection direction) {
                                    ref
                                        .read(currentBookControllerProvider
                                            .notifier)
                                        .removeSummary(summary: summary);
                                  },
                                  child: SummaryListTile(summary: summary),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return sizedBoxH32;
                              },
                            ),
                          ),
                  ),
                ],
              ),
      ),
    );
  }
}

class SummaryListTile extends StatelessWidget {
  const SummaryListTile({
    Key? key,
    required this.summary,
  }) : super(key: key);

  final Summary summary;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: accent.withOpacity(0.3),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(8),
            ),
          ),
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 16.0),
              child: Text(
                'p.${summary.startPage.toString()} ~ p.${summary.endPage.toString()}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
        ),
        DecoratedBox(
          decoration: const BoxDecoration(
            color: white,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(8),
            ),
          ),
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 16.0),
              child: Text(
                summary.text,
                style: Theme.of(context).textTheme.bodyText2!,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AddSummaryBottomsheet extends HookConsumerWidget {
  const AddSummaryBottomsheet({
    Key? key,
    required this.currentBook,
  }) : super(key: key);

  final Book currentBook;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startPage = useState<int?>(null);
    final endPage = useState<int?>(null);

    final rewardedAd = useState<RewardedAd?>(null);

    useEffect(() {
      RewardedAd.load(
        adUnitId: 'ca-app-pub-3940256099942544/1712485313',
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad loaded.');
            rewardedAd.value = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
          },
        ),
      );

      return null;
    }, []);

    Future<void> addSummary() async {
      if (startPage.value == null || endPage.value == null) {
        return;
      }

      if (rewardedAd.value == null) {
        return;
      }

      rewardedAd.value!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (RewardedAd ad) =>
            print('$ad onAdShowedFullScreenContent.'),
        onAdDismissedFullScreenContent: (RewardedAd ad) {
          print('$ad onAdDismissedFullScreenContent.');
          ad.dispose();
        },
        onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
          print('$ad onAdFailedToShowFullScreenContent: $error');
          ad.dispose();
        },
        onAdImpression: (RewardedAd ad) => print('$ad impression occurred.'),
      );
      rewardedAd.value!.show(onUserEarnedReward: ((ad, reward) {
        print('広告のテストです');
      }));

      await ref.read(currentBookControllerProvider.notifier).addSummary(
            book: currentBook,
            startPage: startPage.value!,
            endPage: endPage.value!,
          );
    }

    return Wrap(
      children: [
        Column(
          children: [
            sizedBoxH16,
            const SizedBox(
              width: 80,
              height: 5,
              child: ColoredBox(color: primaryLight),
            ),
            sizedBoxH16,
            Text(
              AppLocalizations.of(context)!.addingMemo,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            sizedBoxH16,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 80,
                        child: PageSetForm(
                          title: AppLocalizations.of(context)!.startPage,
                          onChange: (value) {
                            startPage.value = int.tryParse(value);
                          },
                        ),
                      ),
                      sizedBoxW24,
                      SizedBox(
                        width: 80,
                        child: PageSetForm(
                          title: AppLocalizations.of(context)!.endPage,
                          onChange: (value) {
                            endPage.value = int.tryParse(value);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            sizedBoxH24,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 180,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                      ),
                      onPressed:
                          (startPage.value == null || endPage.value == null)
                              ? null
                              : () {
                                  addSummary();
                                  Navigator.of(context).pop();
                                },
                      child: Text(
                        AppLocalizations.of(context)!.save,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(color: white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            sizedBoxH32,
          ],
        ),
      ],
    );
  }
}
