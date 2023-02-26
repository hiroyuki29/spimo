import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spimo/common_widget/app_bar/common_app_bar.dart';
import 'package:spimo/common_widget/async_value/async_value_widget.dart';
import 'package:spimo/common_widget/color/color.dart';
import 'package:spimo/common_widget/compornent/no_data_display_widget.dart';
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: accent,
        onPressed: () {
          context.goNamed(AppRoute.searchBooks.name);
        },
        child: const Icon(Icons.add),
      ),
      appBar: CommonAppBar(
        context: context,
        title: 'books',
      ),
      endDrawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
                decoration: BoxDecoration(color: primaryLight),
                child: Text("ソート項目")),
            SortDrawerTile(
              title: "タイトル順",
              isSelected: sortType == BookSortType.title,
              onTap: () => ref.read(bookSortTypeProvider.notifier).state =
                  BookSortType.title,
            ),
            SortDrawerTile(
              title: "登録順",
              isSelected: sortType == BookSortType.dateTime,
              onTap: () => ref.read(bookSortTypeProvider.notifier).state =
                  BookSortType.dateTime,
            ),
            SortDrawerTile(
              title: "メモ合計文字数順",
              isSelected: sortType == BookSortType.ranking,
              onTap: () => ref.read(bookSortTypeProvider.notifier).state =
                  BookSortType.ranking,
            ),
          ],
        ),
      ),
      body: AsyncValueWidget(
        value: books,
        data: (value) => value.isEmpty
            ? NoDataDisplayWidget(
                text: '登録している本がありません。\n検索して本を登録しよう！',
                icon: Icon(
                  Icons.search,
                  size: 160,
                  color: Colors.grey.shade300,
                ),
                onTap: () => context.goNamed(AppRoute.searchBooks.name),
              )
            : Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
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
    return ListTile(
      onTap: onTap,
      // tileColor: isSelected ? accent.withOpacity(0.3) : color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
        style: Theme.of(context).textTheme.subtitle2,
      ),
    );
  }
}
