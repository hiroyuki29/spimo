// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_memo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FirestoreMemo _$$_FirestoreMemoFromJson(Map<String, dynamic> json) =>
    _$_FirestoreMemo(
      id: json['id'] as String,
      contents: (json['contents'] as List<dynamic>)
          .map((e) => MemoText.fromJson(e as Map<String, dynamic>))
          .toList(),
      bookId: json['bookId'] as String,
      startPage: json['startPage'] as int?,
      endPage: json['endPage'] as int?,
      createdAt: const TimestampToDatetimeConverter()
          .fromJson(json['createdAt'] as Timestamp),
    );

Map<String, dynamic> _$$_FirestoreMemoToJson(_$_FirestoreMemo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'contents': instance.contents,
      'bookId': instance.bookId,
      'startPage': instance.startPage,
      'endPage': instance.endPage,
      'createdAt':
          const TimestampToDatetimeConverter().toJson(instance.createdAt),
    };