import 'package:freezed_annotation/freezed_annotation.dart';

part 'google_book.freezed.dart';
part 'google_book.g.dart';

@freezed
class GoogleBook with _$GoogleBook {
  const factory GoogleBook({
    required String id,
    required Map<String, dynamic> volumeInfo,
  }) = _GoogleBook;

  factory GoogleBook.fromJson(Map<String, dynamic> json) =>
      _$GoogleBookFromJson(json);
}
