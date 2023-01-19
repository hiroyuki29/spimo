import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spimo/features/books/domain/model/book.dart';
import 'package:spimo/features/books/domain/repository/books_repository.dart';

class BooksHomeScreen extends HookConsumerWidget {
  const BooksHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchWord = useTextEditingController(text: '');
    final books = useState<List<Book>>([]);
    final book = useState<Book?>(null);

    Future<void> fetchBooks() async {
      final searchedBookList =
          await ref.read(booksProvider).getBookList(searchWord.text);
      books.value = searchedBookList;
      final id = books.value[5].id;
      book.value = await ref.read(booksProvider).getBook(id);
    }

    return Scaffold(
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
            books.value.isEmpty || book.value == null
                ? const Text('データなし')
                : SingleChildScrollView(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: books.value.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            // if (book.value!.imageLinks != '')
                            //   Image.network(book.value!.imageLinks!),
                            Text(books.value[index].title.toString()),
                            Text(books.value[index].authors.toString()),
                          ],
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
