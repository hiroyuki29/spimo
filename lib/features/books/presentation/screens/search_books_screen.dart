import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spimo/common_widget/app_bar/common_app_bar.dart';
import 'package:spimo/features/books/domain/model/book.dart';
import 'package:spimo/features/books/domain/repository/search_books_repository.dart';
import 'package:spimo/features/books/presentation/controller/books_controller.dart';

class SearchBooksScreen extends HookConsumerWidget {
  const SearchBooksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchWord = useTextEditingController(text: '');
    final books = useState<List<Book>>([]);
    final book = useState<Book?>(null);

    Future<void> fetchBooks() async {
      final searchedBookList =
          await ref.read(searchBooksProvider).getBookList(searchWord.text);
      books.value = searchedBookList;
    }

    return Scaffold(
      appBar: CommonAppBar(context),
      body: SafeArea(
        child: Column(
          children: [
            TextFormField(
              controller: searchWord,
            ),
            TextButton(
              onPressed: () {
                fetchBooks();
              },
              child: const Text('click'),
            ),
            books.value.isEmpty
                ? const Text('データなし')
                : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: books.value.length,
                        itemBuilder: (context, index) {
                          final book = books.value[index];
                          return Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  ref
                                      .read(booksControllerProvider.notifier)
                                      .addBook(book);
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    children: [
                                      if (book.imageLinks != null)
                                        SizedBox(
                                          height: 100,
                                          child:
                                              Image.network(book.imageLinks!),
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
          ],
        ),
      ),
    );
  }
}
