import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spimo/features/memos/domain/model/memo.dart';
import 'package:spimo/util/converter/timestamp_to_datetime_converter.dart';

part 'book.freezed.dart';
part 'book.g.dart';

@freezed
class Book with _$Book {
  const factory Book({
    required String id,
    required String title,
    List<String>? authors,
    String? imageLinks,
    int? pageCount,
    @TimestampToDatetimeConverter() required DateTime createdAt,
    @Default(0) int totalMemoCount,
    @Default([]) List<Memo> memoList,
  }) = _Book;

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
}
