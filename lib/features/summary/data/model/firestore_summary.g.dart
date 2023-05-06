// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FirestoreSummary _$$_FirestoreSummaryFromJson(Map<String, dynamic> json) =>
    _$_FirestoreSummary(
      id: json['id'] as String,
      text: json['text'] as String,
      bookId: json['bookId'] as String,
      startPage: json['startPage'] as int,
      endPage: json['endPage'] as int,
      createdAt: const TimestampToDatetimeConverter()
          .fromJson(json['createdAt'] as Timestamp),
    );

Map<String, dynamic> _$$_FirestoreSummaryToJson(_$_FirestoreSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'bookId': instance.bookId,
      'startPage': instance.startPage,
      'endPage': instance.endPage,
      'createdAt':
          const TimestampToDatetimeConverter().toJson(instance.createdAt),
    };
