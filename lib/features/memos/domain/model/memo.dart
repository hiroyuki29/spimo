import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spimo/features/memos/domain/model/memo_text.dart';
import 'package:spimo/util/converter/timestamp_to_datetime_converter.dart';

part 'memo.freezed.dart';
part 'memo.g.dart';

@freezed
class Memo with _$Memo {
  const Memo._();
  factory Memo({
    required String id,
    required List<MemoText> contents,
    required String bookId,
    int? startPage,
    int? endPage,
    required DateTime createdAt,
  }) = _Memo;

  factory Memo.fromJson(Map<String, dynamic> json) => _$MemoFromJson(json);

  int get memoTextLength =>
      contents.fold(0, (len, memoText) => len + memoText.text.length);
}
