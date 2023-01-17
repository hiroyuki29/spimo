import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spimo/domain/book/book.dart';
import 'package:spimo/domain/google_books_apis/volume_info.dart';

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
    );
  }
}
