import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spimo/common_widget/app_bar/common_app_bar.dart';
import 'package:spimo/common_widget/async_value/async_value_widget.dart';
import 'package:spimo/common_widget/color/color.dart';
import 'package:spimo/features/books/presentation/controller/current_book_controller.dart';
import 'package:spimo/features/books/presentation/ui_compornent/book_list_tile.dart';
import 'package:spimo/features/memos/presentation/controller/memos_controller.dart';

class MemosHomeScreen extends HookConsumerWidget {
  const MemosHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memos = ref.watch(memosControllerProvider);
    final currentBook = ref.watch(currentBookControllerProvider);

    // useEffect(() {
    //   Future(() async {
    //     currentBook.whenData((value) async {
    //       await ref.read(memosControllerProvider.notifier).fetchBookMemos();
    //     });
    //   });
    //   return null;
    // }, [currentBook]);

    return Scaffold(
      appBar: CommonAppBar(context: context, title: 'memos'),
      body: currentBook == null
          ? const Text('no data')
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BookListTile(
                    book: currentBook,
                    radius: 10,
                    color: primaryLight,
                  ),
                ),
                Expanded(
                  child: AsyncValueWidget(
                      value: memos,
                      data: (memos) {
                        return memos.isEmpty
                            ? const Text('no data')
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: ListView.separated(
                                  itemCount: memos.length,
                                  itemBuilder: (context, index) {
                                    final memo = memos[index];
                                    return ListTile(
                                      title: Row(
                                        children: [
                                          Text(
                                              'p.${memo.startPage?.toString() ?? ''} ~\n  p.${memo.endPage?.toString() ?? ''}'),
                                          const SizedBox(width: 10),
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
                                      onTap: () {
                                        ref
                                            .read(memosControllerProvider
                                                .notifier)
                                            .removeMemo(memo: memo);
                                      },
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const Divider(
                                      height: 1,
                                      color: Colors.black,
                                    );
                                  },
                                ),
                              );
                      }),
                ),
              ],
            ),
    );
  }
}
