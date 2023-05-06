import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spimo/features/memos/domain/model/memo_length_stock.dart';
import 'package:spimo/util/converter/timestamp_to_datetime_converter.dart';

part 'firestore_memo_length_stock.freezed.dart';
part 'firestore_memo_length_stock.g.dart';

@freezed
class FirestoreMemoLengthStock with _$FirestoreMemoLengthStock {
  const FirestoreMemoLengthStock._();

  const factory FirestoreMemoLengthStock({
    required int memoLength,
    @TimestampToDatetimeConverter() required DateTime date,
  }) = _FirestoreMemoLengthStock;

  factory FirestoreMemoLengthStock.fromJson(Map<String, dynamic> json) =>
      _$FirestoreMemoLengthStockFromJson(json);

  MemoLengthStock transferMemoLengthStock() {
    return MemoLengthStock(
      memoLength: memoLength,
      date: date,
    );
  }
}
