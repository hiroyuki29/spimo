import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spimo/features/memos/domain/model/memo.dart';
import 'package:spimo/features/memos/domain/model/memo_text.dart';
import 'package:spimo/util/converter/timestamp_to_datetime_converter.dart';

part 'firestore_memo.freezed.dart';
part 'firestore_memo.g.dart';

@freezed
class FirestoreMemo with _$FirestoreMemo {
  const FirestoreMemo._();

  const factory FirestoreMemo({
    required String id,
    required List<MemoText> contents,
    required String bookId,
    required int startPage,
    @TimestampToDatetimeConverter() required DateTime createdAt,
    required bool isTitle,
  }) = _FirestoreMemo;

  factory FirestoreMemo.fromJson(Map<String, dynamic> json) =>
      _$FirestoreMemoFromJson(json);

  Memo transferToMemo() {
    return Memo(
      id: id,
      contents: contents,
      bookId: bookId,
      startPage: startPage,
      createdAt: createdAt,
      isTitle: isTitle,
    );
  }
}
