import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spimo/common_widget/async_value/async_value_widget.dart';
import 'package:spimo/features/books/presentation/controller/books_controller.dart';
import 'package:spimo/routing/app_router.dart';

class BooksHomeScreen extends HookConsumerWidget {
  const BooksHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: value.length,
              itemBuilder: (context, index) {
                final book = value[index];
                return Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.withOpacity(0.1)),
                      onPressed: () {
                        ref
                            .read(booksControllerProvider.notifier)
                            .removeBook(book);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            if (book.imageLinks != null)
                              SizedBox(
                                height: 100,
                                child: Image.network(book.imageLinks!),
                              ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    book.title.toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    book.authors.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
