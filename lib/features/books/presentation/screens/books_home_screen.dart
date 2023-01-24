import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spimo/common_widget/async_value/async_value_widget.dart';
import 'package:spimo/features/books/presentation/controller/books_controller.dart';
import 'package:spimo/features/books/presentation/controller/current_book_controller.dart';
import 'package:spimo/features/books/presentation/ui_compornent/book_list_tile.dart';
import 'package:spimo/routing/app_router.dart';

class BooksHomeScreen extends StatefulHookConsumerWidget {
  const BooksHomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BooksHomeScreenState();
}

class _BooksHomeScreenState extends ConsumerState<BooksHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final books = ref.watch(booksControllerProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goNamed(AppRoute.searchBooks.name);
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: AsyncValueWidget(
          value: books,
          data: (value) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: value.length,
              itemBuilder: (context, index) {
                final book = value[index];
                return Dismissible(
                  // key: ValueKey<Book>(book),
                  key: UniqueKey(),
                  background: Container(
                    color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        SizedBox(width: 20),
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
                        SizedBox(width: 20),
                      ],
                    ),
                  ),
                  onDismissed: (DismissDirection direction) {
                    ref.read(booksControllerProvider.notifier).removeBook(book);
                  },
                  child: BookListTile(
                    book: book,
                    onTap: () {
                      //TODO:本の詳細ページへの遷移追加(以下は暫定)
                      ref
                          .read(currentBookControllerProvider.notifier)
                          .setCurrentBookId(book.id);
                      context.goNamed(AppRoute.record.name);
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 1,
                  color: Colors.black,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
