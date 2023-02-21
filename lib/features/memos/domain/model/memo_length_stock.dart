import 'package:freezed_annotation/freezed_annotation.dart';

part 'memo_length_stock.freezed.dart';
part 'memo_length_stock.g.dart';

@freezed
class MemoLengthStock with _$MemoLengthStock {
  const factory MemoLengthStock({
    required int memoLength,
    required DateTime date,
  }) = _MemoLengthStock;

  factory MemoLengthStock.fromJson(Map<String, dynamic> json) =>
      _$MemoLengthStockFromJson(json);
}
