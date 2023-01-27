import 'package:flutter/material.dart';
import 'package:spimo/common_widget/color/color.dart';
import 'package:spimo/features/books/domain/model/book.dart';

class BookListTile extends StatelessWidget {
  const BookListTile({
    Key? key,
    required this.book,
    this.color = white,
    this.radius = 0,
    this.onTap,
  }) : super(key: key);

  final Book book;
  final VoidCallback? onTap;
  final Color color;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      tileColor: color,
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
      title: Column(
        children: [
          Text(
            book.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            book.authors.toString(),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: const TextStyle(fontSize: 12),
          ),
          Text(
            book.pageCount.toString(),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
