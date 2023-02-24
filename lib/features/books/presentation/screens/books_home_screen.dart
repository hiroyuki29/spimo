import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spimo/common_widget/app_bar/common_app_bar.dart';
import 'package:spimo/common_widget/async_value/async_value_widget.dart';
import 'package:spimo/common_widget/color/color.dart';
import 'package:spimo/common_widget/indicator/loading_circle_indicator.dart';
import 'package:spimo/features/account/presentation/controller/user_controller.dart';
import 'package:spimo/features/books/domain/model/book.dart';
import 'package:spimo/features/books/presentation/controller/books_controller.dart';
import 'package:spimo/features/books/presentation/controller/current_book_controller.dart';
import 'package:spimo/features/books/presentation/ui_compornent/book_list_view.dart';
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
    final user = ref.watch(userControllerProvider);
    final currentBookNotifier =
        ref.watch(currentBookControllerProvider.notifier);

    return Scaffold(
      backgroundColor: backgroundGray,
      floatingActionButton: FloatingActionButton(
        backgroundColor: accent,
        onPressed: () {
          context.goNamed(AppRoute.searchBooks.name);
        },
        child: const Icon(Icons.add),
      ),
      appBar: CommonAppBar(context: context, title: 'books'),
      body: AsyncValueWidget(
        value: books,
        data: (value) => user == null
            ? const LoadingCircleIndicator()
            : Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: BookListView(
                  bookList: value,
                  currentBookId: user.currentBookId,
                  slideCallback: ((Book book) {
                    ref.read(booksControllerProvider.notifier).removeBook(book);
                  }),
                  onTap: (Book book) {
                    currentBookNotifier.setCurrentBookId(book.id);
                  },
                ),
              ),
      ),
    );
  }
}
