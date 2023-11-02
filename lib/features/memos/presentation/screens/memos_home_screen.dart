import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spimo/common/widget/app_bar/common_app_bar.dart';
import 'package:spimo/common/widget/async_value/async_value_widget.dart';
import 'package:spimo/common/widget/color/color.dart';
import 'package:spimo/common/widget/compornent/no_data_display_widget.dart';
import 'package:spimo/common/widget/dialog/custom_alert_dialog.dart';
import 'package:spimo/common/widget/sized_box/constant_sized_box.dart';
import 'package:spimo/features/books/domain/model/book.dart';
import 'package:spimo/features/books/presentation/controller/current_book_controller.dart';
import 'package:spimo/features/memos/domain/model/memo.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:spimo/features/memos/domain/model/memo_text.dart';
import 'package:spimo/features/record/presentation/record_home_screen.dart';
import 'package:spimo/features/summary/presentation/screens/summary_home_screen.dart';
import 'package:spimo/routing/app_router.dart';

class MemosHomeScreen extends HookConsumerWidget {
  const MemosHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(initialLength: 2);
    final currentBook = ref.watch(currentBookControllerProvider);

    List<Widget> tabs = [
      Tab(
        child: Text(
          AppLocalizations.of(context)!.memo,
          style: const TextStyle(color: primaryDark),
        ),
      ),
      Tab(
        child: Text(
          AppLocalizations.of(context)!.summary,
          style: const TextStyle(color: primaryDark),
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: backgroundGray,
      appBar: CommonAppBar(
        context: context,
        title: 'Memo',
        action: IconButton(
          onPressed: () {
            context.pushNamed(AppRoute.introduction.name);
          },
          icon: const Icon(Icons.info_outline),
        ),
      ),
      body: AsyncValueWidget(
        value: currentBook,
        data: (currentBook) => currentBook == null
            ? const NoSelectedBookWidget()
            : Column(
                children: [
                  ColoredBox(
                    color: white,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: Row(
                            children: [
                              sizedBoxW16,
                              SizedBox(
                                height: 80,
                                child: Image.network(
                                  currentBook.imageLinks ?? '',
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.image_not_supported_outlined,
                                    );
                                  },
                                ),
                              ),
                              sizedBoxW24,
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      currentBook.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                    Text(
                                      currentBook.authors.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    Text(
                                      '${currentBook.pageCount.toString()} ${AppLocalizations.of(context)!.pages}',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        TabBar(
                          controller: tabController,
                          indicatorColor: primaryDark,
                          indicatorWeight: 3,
                          tabs: tabs,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(controller: tabController, children: [
                      MemoListView(
                        currentBook: currentBook,
                      ),
                      SummaryHomeScreen(
                        currentBook: currentBook,
                      ),
                    ]),
                  ),
                ],
              ),
      ),
    );
  }
}

class MemoListView extends ConsumerWidget {
  const MemoListView({
    Key? key,
    required this.currentBook,
  }) : super(key: key);

  final Book currentBook;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        currentBook.memoList.isEmpty
            ? const NoSavedMemoWidget()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView.separated(
                  padding: const EdgeInsets.only(top: 16, bottom: 100),
                  itemCount: currentBook.memoList.length,
                  itemBuilder: (context, index) {
                    final memo = currentBook.memoList[index];
                    return Dismissible(
                      key: UniqueKey(),
                      background: Container(
                        color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
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
                      confirmDismiss: (DismissDirection direction) async {
                        return await showCupertinoDialog(
                          context: context,
                          builder: (context) {
                            return CustomAlertDialog(
                              title:
                                  AppLocalizations.of(context)!.deleteMemoTitle,
                              content: AppLocalizations.of(context)!
                                  .deleteMemoContent,
                              leftText: AppLocalizations.of(context)!.delete,
                              rightText: AppLocalizations.of(context)!.cancel,
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
                            .read(currentBookControllerProvider.notifier)
                            .removeMemo(memo: memo);
                      },
                      child: MemoListTile(memo: memo),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return sizedBoxH8;
                  },
                ),
              ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16, right: 16),
            child: FloatingActionButton(
              backgroundColor: accent,
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
                      child: AddHeadingTitleBottomSheet(
                        currentBook: currentBook,
                      ),
                    );
                  },
                );
              },
              child: const Icon(Icons.add),
            ),
          ),
        )
      ],
    );
  }
}

class MemoListTile extends StatelessWidget {
  const MemoListTile({
    Key? key,
    required this.memo,
  }) : super(key: key);

  final Memo memo;

  @override
  Widget build(BuildContext context) {
    String pageDisplay = 'p.${memo.startPage.toString()}';

    return ListTile(
      tileColor: memo.isTitle ? Colors.transparent : white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      title: Row(
        children: [
          memo.isTitle
              ? Text(
                  'p.${memo.startPage.toString()} ',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: accent),
                )
              : Text(
                  pageDisplay,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
          sizedBoxW16,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: memo.contents.map((text) {
                return Text(
                  text.text,
                  style: memo.isTitle
                      ? Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: accent,
                          )
                      : Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: text.textColor.color,
                          ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class TitleSetForm extends StatelessWidget {
  const TitleSetForm({
    Key? key,
    required this.onChange,
    required this.title,
  }) : super(key: key);

  final void Function(String) onChange;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: title,
        labelStyle: Theme.of(context).textTheme.bodyLarge,
      ),
      keyboardType: TextInputType.text,
      onChanged: onChange,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }
}

class AddHeadingTitleBottomSheet extends HookConsumerWidget {
  const AddHeadingTitleBottomSheet({
    Key? key,
    required this.currentBook,
  }) : super(key: key);

  final Book currentBook;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startPage = useState<int?>(null);
    final endPage = useState<int?>(null);
    final memoLetter = useState<String?>(null);
    final isRedText = useState<bool>(false);
    final isTitle = useState<bool>(false);

    Future<void> addMemo() async {
      if (startPage.value == null || memoLetter.value == null) {
        return;
      }
      final memoText = MemoText(
          text: memoLetter.value!,
          textColor: isRedText.value ? TextColor.red : TextColor.black);
      final memo = Memo(
        id: 'id',
        contents: [memoText],
        startPage: startPage.value!,
        bookId: currentBook.id,
        createdAt: DateTime.now(),
        isTitle: isTitle.value,
      );
      await ref.read(currentBookControllerProvider.notifier).addMemo(
            bookId: currentBook.id,
            memo: memo,
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
              style: Theme.of(context).textTheme.titleSmall,
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
                    ],
                  ),
                  sizedBoxH16,
                  TitleSetForm(
                    title: AppLocalizations.of(context)!.text,
                    onChange: (value) {
                      memoLetter.value = value;
                    },
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CheckBoxWithTitle(
                        title: AppLocalizations.of(context)!.redText,
                        checkItem: isRedText.value,
                        onTap: (_) {
                          isRedText.value = !isRedText.value;
                        },
                      ),
                      CheckBoxWithTitle(
                        title: AppLocalizations.of(context)!.title,
                        checkItem: isTitle.value,
                        onTap: (_) {
                          isTitle.value = !isTitle.value;
                        },
                      ),
                    ],
                  ),
                  sizedBoxW32,
                  SizedBox(
                    width: 180,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                      ),
                      onPressed:
                          (startPage.value == null || memoLetter.value == null)
                              ? null
                              : () {
                                  addMemo();
                                  Navigator.of(context).pop();
                                },
                      child: Text(
                        AppLocalizations.of(context)!.save,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
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

class CheckBoxWithTitle extends StatelessWidget {
  const CheckBoxWithTitle({
    Key? key,
    required this.title,
    required this.checkItem,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final bool checkItem;
  final Function(bool?) onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: checkItem,
          onChanged: onTap,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
