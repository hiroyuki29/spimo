import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spimo/common_widget/app_bar/common_app_bar.dart';
import 'package:spimo/common_widget/async_value/async_value_widget.dart';
import 'package:spimo/common_widget/color/color.dart';
import 'package:spimo/common_widget/sized_box/constant_sized_box.dart';
import 'package:spimo/features/books/presentation/controller/current_book_controller.dart';
import 'package:spimo/features/books/presentation/ui_compornent/book_list_tile.dart';
import 'package:spimo/features/memos/presentation/controller/memos_controller.dart';

class MemosHomeScreen extends HookConsumerWidget {
  const MemosHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memos = ref.watch(memosControllerProvider);
    final currentBook = ref.watch(currentBookControllerProvider);

    useEffect(() {
      Future(
        () async {
          await ref.read(memosControllerProvider.notifier).fetchBookMemos();
        },
      );
      return null;
    }, []);

    return Scaffold(
      backgroundColor: backgroundGray,
      appBar: CommonAppBar(context: context, title: 'memos'),
      body: currentBook == null
          ? const Text('no data')
          : Column(
              children: [
                Container(height: 16, color: backgroundGray),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: BookListTile(
                    book: currentBook,
                  ),
                ),
                Container(height: 16, color: backgroundGray),
                Expanded(
                  child: AsyncValueWidget(
                    value: memos,
                    data: (memos) {
                      return memos.isEmpty
                          ? const Text('no data')
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: ListView.separated(
                                itemCount: memos.length,
                                itemBuilder: (context, index) {
                                  final memo = memos[index];
                                  return Dismissible(
                                    key: UniqueKey(),
                                    background: Container(
                                      color: Colors.red,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: const [
                                          sizedBoxW24,
                                          Icon(Icons.delete,
                                              color: Colors.white),
                                        ],
                                      ),
                                    ),
                                    secondaryBackground: Container(
                                      color: Colors.red,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: const [
                                          Icon(Icons.delete,
                                              color: Colors.white),
                                          sizedBoxW24,
                                        ],
                                      ),
                                    ),
                                    onDismissed: (DismissDirection direction) {
                                      ref
                                          .read(
                                              memosControllerProvider.notifier)
                                          .removeMemo(memo: memo);
                                    },
                                    child: ListTile(
                                      tileColor: white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      title: Row(
                                        children: [
                                          Text(
                                              'p.${memo.startPage?.toString() ?? ''} ~\n  p.${memo.endPage?.toString() ?? ''}'),
                                          sizedBoxW16,
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children:
                                                  memo.contents.map((text) {
                                                return Text(
                                                  text.text,
                                                  style: TextStyle(
                                                    color: text.textColor.color,
                                                    fontSize: 14,
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return sizedBoxH8;
                                },
                              ),
                            );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
