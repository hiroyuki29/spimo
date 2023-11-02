import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spimo/common/widget/app_bar/common_app_bar.dart';
import 'package:spimo/common/widget/async_value/async_value_widget.dart';
import 'package:spimo/common/widget/color/color.dart';
import 'package:spimo/common/widget/compornent/Bubble.dart';
import 'package:spimo/common/widget/compornent/no_data_display_widget.dart';
import 'package:spimo/common/widget/sized_box/constant_sized_box.dart';
import 'package:spimo/features/account/presentation/controller/user_controller.dart';
import 'package:spimo/features/books/domain/model/book.dart';
import 'package:spimo/features/books/presentation/controller/books_controller.dart';
import 'package:spimo/features/books/presentation/controller/current_book_controller.dart';
import 'package:spimo/features/books/presentation/ui_compornent/book_list_view.dart';
import 'package:spimo/features/books/presentation/ui_compornent/current_book_card.dart';
import 'package:spimo/features/home/presentation/screens/home_screen.dart';
import 'package:spimo/routing/app_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BooksHomeScreen extends StatefulHookConsumerWidget {
  const BooksHomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BooksHomeScreenState();
}

class _BooksHomeScreenState extends ConsumerState<BooksHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final currentBook = ref.watch(currentBookControllerProvider);
    final books = ref.watch(sortedBookListProvider);
    final user = ref.watch(userControllerProvider);
    final sortType = ref.watch(bookSortTypeProvider);
    final currentBookNotifier =
        ref.watch(currentBookControllerProvider.notifier);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        ref.read(bookSortTypeProvider.notifier).state = BookSortType.dateTime;
      });
      return null;
    }, []);

    return Scaffold(
      backgroundColor: backgroundGray,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!books.hasValue || books.value!.isEmpty)
            const Padding(
              padding: EdgeInsets.only(right: 0),
              child: Bubble(
                  text: 'まずは本を登録しよう！',
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
            ),
          sizedBoxH16,
          FloatingActionButton(
            backgroundColor: accent,
            onPressed: () {
              context.goNamed(AppRoute.searchBooks.name);
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
      appBar: CommonAppBar(
        context: context,
        title: 'Book',
        action: !books.hasValue || books.value!.isNotEmpty
            ? null
            : IconButton(
                onPressed: () {
                  context.pushNamed(AppRoute.introduction.name);
                },
                icon: const Icon(Icons.info_outline),
              ),
      ),
      endDrawer: !books.hasValue || books.value!.isEmpty
          ? null
          : Drawer(
              child: ListView(
                children: [
                  SizedBox(
                    height: 60,
                    child: DrawerHeader(
                        decoration: const BoxDecoration(color: primaryLight),
                        child: Text(AppLocalizations.of(context)!.sort)),
                  ),
                  SortDrawerTile(
                    title: AppLocalizations.of(context)!.title,
                    isSelected: sortType == BookSortType.title,
                    onTap: () => ref.read(bookSortTypeProvider.notifier).state =
                        BookSortType.title,
                  ),
                  SortDrawerTile(
                    title: AppLocalizations.of(context)!.registeredDay,
                    isSelected: sortType == BookSortType.dateTime,
                    onTap: () => ref.read(bookSortTypeProvider.notifier).state =
                        BookSortType.dateTime,
                  ),
                  SortDrawerTile(
                    title: AppLocalizations.of(context)!.characterCount,
                    isSelected: sortType == BookSortType.ranking,
                    onTap: () => ref.read(bookSortTypeProvider.notifier).state =
                        BookSortType.ranking,
                  ),
                ],
              ),
            ),
      body: Column(
        children: [
          AsyncValueWidget(
            value: currentBook,
            data: (book) => book == null
                ? const NoSelectedBookWidget()
                : ColoredBox(
                    color: backgroundGray,
                    child: Column(
                      children: [
                        HomeContent(
                          title: AppLocalizations.of(context)!.selectedBook,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: CurrentBookCard(
                              isSelected: true,
                              book: book,
                            ),
                          ),
                        ),
                        Container(height: 16, color: backgroundGray),
                      ],
                    ),
                  ),
          ),
          if ((!currentBook.hasValue || currentBook.value == null) &&
              (!books.hasValue || books.value!.isNotEmpty))
            Column(
              children: const [
                sizedBoxH16,
                Padding(
                  padding: EdgeInsets.only(right: 0),
                  child: Bubble(
                      text: '読書メモをしたい本をタップ！',
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                ),
                sizedBoxH16,
              ],
            ),
          Expanded(
            child: AsyncValueWidget(
              value: books,
              data: (value) => value.isEmpty
                  ? NoDataDisplayWidget(
                      text: AppLocalizations.of(context)!.noRegisterdBook,
                      icon: Icon(
                        Icons.search,
                        size: 160,
                        color: Colors.grey.shade300,
                      ),
                      onTap: () => context.goNamed(AppRoute.searchBooks.name),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      child: BookListView(
                        bookList: value,
                        currentBookId: user!.currentBookId,
                        slideCallback: ((Book book) {
                          if (book.id == user.currentBookId) {
                            currentBookNotifier.reset();
                            ref
                                .read(userControllerProvider.notifier)
                                .resetCurrentBookId;
                          }
                          ref
                              .read(booksControllerProvider.notifier)
                              .removeBook(book);
                        }),
                        onTap: (Book book) {
                          currentBookNotifier.setCurrentBookId(book.id);
                        },
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class SortDrawerTile extends StatelessWidget {
  const SortDrawerTile({
    Key? key,
    required this.title,
    this.color = white,
    this.radius = 8,
    this.onTap,
    required this.isSelected,
  }) : super(key: key);

  final String title;
  final VoidCallback? onTap;
  final Color color;
  final double radius;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: onTap,
        tileColor: isSelected ? accent.withOpacity(0.3) : color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        leading: isSelected
            ? const Icon(
                Icons.check,
                color: accent,
                size: 30,
              )
            : null,
        title: Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
    );
  }
}
