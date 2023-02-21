// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memo_length_stock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MemoLengthStock _$$_MemoLengthStockFromJson(Map<String, dynamic> json) =>
    _$_MemoLengthStock(
      memoLength: json['memoLength'] as int,
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$$_MemoLengthStockToJson(_$_MemoLengthStock instance) =>
    <String, dynamic>{
      'memoLength': instance.memoLength,
      'date': instance.date.toIso8601String(),
    };
