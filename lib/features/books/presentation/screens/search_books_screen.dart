import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spimo/common_widget/app_bar/common_app_bar.dart';
import 'package:spimo/common_widget/color/color.dart';
import 'package:spimo/features/books/domain/model/book.dart';
import 'package:spimo/features/books/domain/repository/search_books_repository.dart';
import 'package:spimo/features/books/presentation/controller/books_controller.dart';
import 'package:spimo/features/books/presentation/ui_compornent/book_list_view.dart';
import 'package:spimo/routing/app_router.dart';

class SearchBooksScreen extends HookConsumerWidget {
  const SearchBooksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchWord = useTextEditingController(text: '');
    final books = useState<List<Book>>([]);

    Future<void> fetchBooks() async {
      final searchedBookList =
          await ref.read(searchBooksProvider).getBookList(searchWord.text);
      books.value = searchedBookList;
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: backgroundGray,
        appBar: CommonAppBar(context: context, title: 'search books'),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 20,
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: white,
                  isDense: true,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: primaryDark,
                  ),
                  hintText: '本の名称',
                  hintStyle: Theme.of(context).textTheme.bodyText1,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                ),
                controller: searchWord,
                onEditingComplete: () {
                  fetchBooks();
                  FocusScope.of(context).unfocus();
                },
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            books.value.isEmpty
                ? const Text('データなし')
                : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: BookListView(
                          bookList: books.value,
                          onTap: (Book book) {
                            ref
                                .read(booksControllerProvider.notifier)
                                .addBook(book);
                            context.goNamed(AppRoute.books.name);
                          }),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
