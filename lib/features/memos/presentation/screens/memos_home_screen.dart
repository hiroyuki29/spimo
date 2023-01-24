import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spimo/common_widget/async_value/async_value_widget.dart';
import 'package:spimo/features/books/presentation/controller/current_book_controller.dart';
import 'package:spimo/features/memos/presentation/controller/memos_controller.dart';

class MemosHomeScreen extends HookConsumerWidget {
  const MemosHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memos = ref.watch(memosControllerProvider);
    final currentBook = ref.watch(currentBookControllerProvider);

    useEffect(() {
      Future(() async {
        currentBook.whenData((value) async {
          await ref
              .read(memosControllerProvider.notifier)
              .fetchBookMemos(value!);
        });
      });
      return null;
    }, [currentBook]);

    return AsyncValueWidget(
        value: memos,
        data: (memos) {
          return SafeArea(
            child: memos.isEmpty
                ? const Text('no data')
                : ListView.separated(
                    shrinkWrap: true,
                    itemCount: memos.length,
                    itemBuilder: (context, index) {
                      final memo = memos[index];
                      return ListTile(
                        title: Column(
                          children: memo.contents.map((text) {
                            return Text(
                              text.text,
                              style: TextStyle(
                                color: text.textColor.color,
                              ),
                            );
                          }).toList(),
                        ),
                        onTap: () {},
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
        });
  }
}
