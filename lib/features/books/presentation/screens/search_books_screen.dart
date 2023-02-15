import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spimo/common_widget/app_bar/common_app_bar.dart';
import 'package:spimo/common_widget/color/color.dart';
import 'package:spimo/common_widget/indicator/loading_circle_indicator.dart';
import 'package:spimo/common_widget/sized_box/constant_sized_box.dart';
import 'package:spimo/features/books/domain/model/book.dart';
import 'package:spimo/features/books/domain/repository/search_books_repository.dart';
import 'package:spimo/features/books/presentation/controller/books_controller.dart';
import 'package:spimo/features/books/presentation/ui_compornent/book_list_view.dart';
import 'package:spimo/routing/app_router.dart';

class SearchBooksScreen extends HookConsumerWidget {
  const SearchBooksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchWord = useTextEditingController(text: null);
    final searchIndex = useState<int>(0);
    final books = useState<List<Book>>([]);
    final isLoading = useState<bool>(false);

    Future<void> fetchBooks() async {
      isLoading.value = true;
      final searchedBookList = await ref.read(searchBooksProvider).getBookList(
            keyword: searchWord.text,
            index: searchIndex.value,
          );
      books.value += searchedBookList;
      Future.delayed(
        const Duration(
          milliseconds: 500,
        ),
        () => isLoading.value = false,
      );
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 60,
                      child: Center(
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
                              borderSide:
                                  const BorderSide(color: primary, width: 0.5),
                            ),
                          ),
                          controller: searchWord,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ),
                  ),
                  sizedBoxW16,
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        books.value = [];
                        searchIndex.value = 0;
                        fetchBooks();
                        FocusScope.of(context).unfocus();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accent,
                      ),
                      child: const Center(
                          child: Icon(
                        Icons.search,
                        color: white,
                      )),
                    ),
                  ),
                ],
              ),
            ),
            books.value.isEmpty
                ? const Text('データなし')
                : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (notification) {
                          final scrollProportion = notification.metrics.pixels /
                              notification.metrics.maxScrollExtent;
                          if (scrollProportion > 0.99 && !isLoading.value) {
                            searchIndex.value += 1;
                            fetchBooks();
                          }
                          return false;
                        },
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
                  ),
            isLoading.value
                ? const LoadingCircleIndicator()
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
