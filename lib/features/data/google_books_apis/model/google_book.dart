import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spimo/features/data/google_books_apis/model/volume_info.dart';
import 'package:spimo/features/domain/model/book/book.dart';

part 'google_book.freezed.dart';
part 'google_book.g.dart';

@freezed
class GoogleBook with _$GoogleBook {
  const GoogleBook._();

  const factory GoogleBook({
    required String id,
    required VolumeInfo volumeInfo,
  }) = _GoogleBook;

  factory GoogleBook.fromJson(Map<String, dynamic> json) =>
      _$GoogleBookFromJson(json);

  Book transferToBook() {
    return Book(
      id: id,
      title: volumeInfo.title,
      authors: volumeInfo.authors,
      pageCount: volumeInfo.pageCount ?? 0,
      imageLinks: volumeInfo.imageLinks?.thumbnail ?? '',
    );
  }
}
