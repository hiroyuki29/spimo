import 'package:flutter/material.dart';
import 'package:spimo/common/widget/color/color.dart';
import 'package:spimo/common/widget/sized_box/constant_sized_box.dart';
import 'package:spimo/features/books/domain/model/book.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CurrentBookCard extends StatelessWidget {
  const CurrentBookCard({
    Key? key,
    required this.book,
    this.color = white,
    this.radius = 8,
    required this.isSelected,
  }) : super(key: key);

  final Book book;
  final Color color;
  final double radius;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: isSelected ? accent.withOpacity(0.3) : color,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          SizedBox(
            height: 80,
            child: Image.network(
              book.imageLinks ?? '',
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.image_not_supported_outlined,
                );
              },
            ),
          ),
          sizedBoxW24,
          Expanded(
            child: Column(
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
                  '${book.pageCount.toString()} ${AppLocalizations.of(context)!.pages}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
