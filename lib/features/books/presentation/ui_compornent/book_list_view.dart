import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spimo/common/widget/dialog/custom_alert_dialog.dart';
import 'package:spimo/common/widget/sized_box/constant_sized_box.dart';
import 'package:spimo/features/books/domain/model/book.dart';
import 'package:spimo/features/books/presentation/ui_compornent/book_list_tile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookListView extends StatelessWidget {
  const BookListView({
    Key? key,
    required this.bookList,
    this.slideCallback,
    required this.onTap,
    this.currentBookId,
    this.dismissible = true,
  }) : super(key: key);

  final List<Book> bookList;
  final Function? slideCallback;
  final Function onTap;
  final String? currentBookId;
  final bool dismissible;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: bookList.length + 1,
      itemBuilder: (context, index) {
        return index != bookList.length
            ? dismissible
                ? DismissibleBookTile(
                    index: index,
                    slideCallback: slideCallback,
                    bookList: bookList,
                    currentBookId: currentBookId,
                    onTap: onTap,
                  )
                : BookListTile(
                    isSelected: bookList[index].id == currentBookId,
                    book: bookList[index],
                    onTap: () {
                      onTap(bookList[index]);
                    },
                  )
            : const SizedBox(height: 80);
      },
      separatorBuilder: (context, index) {
        return sizedBoxH8;
      },
    );
  }
}

class DismissibleBookTile extends StatelessWidget {
  const DismissibleBookTile({
    Key? key,
    required this.index,
    required this.slideCallback,
    required this.bookList,
    required this.currentBookId,
    required this.onTap,
  }) : super(key: key);

  final int index;
  final Function? slideCallback;
  final List<Book> bookList;
  final String? currentBookId;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
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
      confirmDismiss: (DismissDirection direction) async {
        return await showCupertinoDialog(
          context: context,
          builder: (context) {
            return CustomAlertDialog(
              title: AppLocalizations.of(context)!.removeBookTitle,
              content: AppLocalizations.of(context)!.removeBookContent,
              leftText: AppLocalizations.of(context)!.delete,
              rightText: AppLocalizations.of(context)!.cancel,
              onTapLeft: () {
                Navigator.of(context).pop(true);
              },
              onTapRight: () {
                Navigator.of(context).pop(false);
              },
            );
          },
        );
      },
      onDismissed: (DismissDirection direction) {
        if (slideCallback == null) {
          return;
        }
        slideCallback!(bookList[index]);
      },
      child: BookListTile(
        isSelected: bookList[index].id == currentBookId,
        book: bookList[index],
        onTap: () {
          onTap(bookList[index]);
        },
      ),
    );
  }
}
