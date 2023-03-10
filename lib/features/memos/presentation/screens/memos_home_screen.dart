import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
import 'package:spimo/features/memos/domain/model/memo.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:spimo/features/record/presentation/record_home_screen.dart';

class MemosHomeScreen extends HookConsumerWidget {
  const MemosHomeScreen({super.key});

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
                        child: AddHeadingTitleBottomSheet(
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
                    child: currentBook.memoList.isEmpty
                        ? const NoSavedMemoWidget()
                        : Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: ListView.separated(
                              itemCount: currentBook.memoList.length,
                              itemBuilder: (context, index) {
                                final memo = currentBook.memoList[index];
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
                  ),
                ],
              ),
      ),
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
    return ListTile(
      tileColor: memo.isTitle ? Colors.transparent : white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      title: Row(
        children: [
          memo.isTitle
              ? Text(
                  'p.${memo.startPage?.toString() ?? ''} ',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: accent),
                )
              : Text(
                  'p.${memo.startPage?.toString() ?? ''} ~\n  p.${memo.endPage?.toString() ?? ''}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
          sizedBoxW16,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: memo.contents.map((text) {
                return Text(
                  text.text,
                  style: memo.isTitle
                      ? Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: accent,
                          )
                      : Theme.of(context).textTheme.bodyText2!.copyWith(
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
        labelStyle: Theme.of(context).textTheme.bodyText1,
      ),
      keyboardType: TextInputType.text,
      onChanged: onChange,
      style: Theme.of(context).textTheme.bodyText1,
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
    final titlePage = useState<int?>(null);
    final headingTitle = useState<String?>(null);

    Future<void> saveHeadingTitle() async {
      if (titlePage.value == null || headingTitle.value == null) {
        return;
      }
      await ref.read(currentBookControllerProvider.notifier).addHeadingTitle(
          bookId: currentBook.id,
          page: titlePage.value!,
          title: headingTitle.value!);
    }

    return Container(
      height: 350.0,
      color: Colors.transparent,
      child: Column(
        children: [
          sizedBoxH16,
          const SizedBox(
            width: 80,
            height: 5,
            child: ColoredBox(color: primaryLight),
          ),
          sizedBoxH16,
          Text(
            AppLocalizations.of(context)!.addingAHeadingTitle,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          sizedBoxH16,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageSetForm(
                  title: AppLocalizations.of(context)!.startPage,
                  onChange: (value) {
                    titlePage.value = int.tryParse(value);
                  },
                ),
                sizedBoxH16,
                TitleSetForm(
                  title: AppLocalizations.of(context)!.headingTitle,
                  onChange: (value) {
                    headingTitle.value = value;
                  },
                ),
              ],
            ),
          ),
          sizedBoxH24,
          SizedBox(
            width: 200,
            height: 60,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
              ),
              onPressed: (titlePage.value == null || headingTitle.value == null)
                  ? null
                  : () {
                      saveHeadingTitle();
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
    );
  }
}
