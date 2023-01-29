import 'package:flutter/material.dart';
import 'package:spimo/common_widget/sized_box/constant_sized_box.dart';
import 'package:spimo/features/books/domain/model/book.dart';
import 'package:spimo/features/books/presentation/ui_compornent/book_list_tile.dart';

class BookListView extends StatelessWidget {
  const BookListView({
    Key? key,
    required this.bookList,
    this.slideCallback,
    required this.onTap,
  }) : super(key: key);

  final List<Book> bookList;
  final Function? slideCallback;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: bookList.length + 1,
      itemBuilder: (context, index) {
        return index != bookList.length
            ? Dismissible(
                key: UniqueKey(),
                background: Container(
                  color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      sizedBoxW24,
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
                      sizedBoxW24,
                    ],
                  ),
                ),
                onDismissed: (DismissDirection direction) {
                  if (slideCallback == null) {
                    return;
                  }
                  slideCallback!(bookList[index]);
                },
                child: BookListTile(
                  book: bookList[index],
                  onTap: () {
                    onTap(bookList[index]);
                  },
                ),
              )
            : const SizedBox(height: 80);
      },
      separatorBuilder: (context, index) {
        return sizedBoxH8;
      },
    );
  }
}
