import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spimo/domain/google_books_apis/google_book.dart';

part 'google_books_api_response.freezed.dart';
part 'google_books_api_response.g.dart';

@freezed
class GoogleBooksApiResponse with _$GoogleBooksApiResponse {
  const factory GoogleBooksApiResponse({
    required String kind,
    required int totalItems,
    required List<GoogleBook> items,
  }) = _GoogleBooksApiResponse;

  factory GoogleBooksApiResponse.fromJson(Map<String, dynamic> json) =>
      _$GoogleBooksApiResponseFromJson(json);
}
