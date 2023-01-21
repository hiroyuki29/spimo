import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spimo/util/converter/timestamp_to_datetime_converter.dart';

part 'memo.freezed.dart';
part 'memo.g.dart';

@freezed
class Memo with _$Memo {
  const factory Memo({
    required String id,
    required List<String> texts,
    required String bookId,
    int? startPage,
    int? endPage,
    @TimestampToDatetimeConverter() required DateTime createdAt,
  }) = _Memo;

  factory Memo.fromJson(Map<String, dynamic> json) => _$MemoFromJson(json);
}
