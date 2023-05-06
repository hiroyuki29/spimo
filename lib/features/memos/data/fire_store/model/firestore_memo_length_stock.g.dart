// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_memo_length_stock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FirestoreMemoLengthStock _$$_FirestoreMemoLengthStockFromJson(
        Map<String, dynamic> json) =>
    _$_FirestoreMemoLengthStock(
      memoLength: json['memoLength'] as int,
      date: const TimestampToDatetimeConverter()
          .fromJson(json['date'] as Timestamp),
    );

Map<String, dynamic> _$$_FirestoreMemoLengthStockToJson(
        _$_FirestoreMemoLengthStock instance) =>
    <String, dynamic>{
      'memoLength': instance.memoLength,
      'date': const TimestampToDatetimeConverter().toJson(instance.date),
    };
