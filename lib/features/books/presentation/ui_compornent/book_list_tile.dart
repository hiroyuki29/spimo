import 'package:flutter/material.dart';
import 'package:spimo/common_widget/color/color.dart';
import 'package:spimo/features/books/domain/model/book.dart';

class BookListTile extends StatelessWidget {
  const BookListTile({
    Key? key,
    required this.book,
    this.color = white,
    this.radius = 8,
    this.onTap,
    required this.isSelected,
  }) : super(key: key);

  final Book book;
  final VoidCallback? onTap;
  final Color color;
  final double radius;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      tileColor: isSelected ? accent.withOpacity(0.3) : color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      leading: Image.network(
        book.imageLinks ?? '',
        errorBuilder: (context, error, stackTrace) {
          return const Icon(
            Icons.image_not_supported_outlined,
          );
        },
      ),
      // trailing: isSelected
      //     ? const Icon(
      //         Icons.check,
      //         color: accent,
      //         size: 30,
      //       )
      //     : null,
      title: Column(
        children: [
          Text(
            book.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Text(
            book.authors.toString(),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          Text(
            '${book.pageCount.toString()}ページ',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}
