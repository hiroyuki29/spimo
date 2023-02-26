import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spimo/common_widget/app_bar/common_app_bar.dart';
import 'package:spimo/common_widget/async_value/async_value_widget.dart';
import 'package:spimo/common_widget/color/color.dart';
import 'package:spimo/common_widget/compornent/no_data_display_widget.dart';
import 'package:spimo/common_widget/dialog/custom_alert_dialog.dart';
import 'package:spimo/common_widget/icon_asset/Icon_asset.dart';
import 'package:spimo/common_widget/sized_box/constant_sized_box.dart';
import 'package:spimo/features/books/presentation/controller/current_book_controller.dart';
import 'package:spimo/features/books/presentation/ui_compornent/book_list_tile.dart';
import 'package:spimo/features/memos/domain/model/memo.dart';
import 'package:spimo/routing/app_router.dart';

class MemosHomeScreen extends HookConsumerWidget {
  const MemosHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentBook = ref.watch(currentBookControllerProvider);

    return Scaffold(
      backgroundColor: backgroundGray,
      appBar: CommonAppBar(context: context, title: 'memos'),
      body: AsyncValueWidget(
        value: currentBook,
        data: (currentBook) => currentBook == null
            ? NoDataDisplayWidget(
                text: '選択中の本はありません。\n今読んでいる本を選択しよう！',
                icon: IconAsset.book,
                onTap: () => context.goNamed(AppRoute.books.name),
              )
            : Column(
                children: [
                  Container(height: 16, color: backgroundGray),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: BookListTile(
                      isSelected: false,
                      book: currentBook,
                    ),
                  ),
                  Container(height: 16, color: backgroundGray),
                  Expanded(
                    child: currentBook.memoList.isEmpty
                        ? NoDataDisplayWidget(
                            text: 'まだ保存したメモはありません。\n早速メモしてみましょう！',
                            icon: IconAsset.speech,
                            onTap: () => context.goNamed(
                              AppRoute.record.name,
                            ),
                          )
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
                                          title: 'メモの削除します。\nよろしいですか？',
                                          content: '削除すると元に戻すことはできません。',
                                          leftText: '削除',
                                          rightText: 'キャンセル',
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
      tileColor: white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      title: Row(
        children: [
          Text(
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
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: text.textColor.color),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
