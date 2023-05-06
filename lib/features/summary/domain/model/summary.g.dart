// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Summary _$$_SummaryFromJson(Map<String, dynamic> json) => _$_Summary(
      id: json['id'] as String,
      text: json['text'] as String,
      bookId: json['bookId'] as String,
      startPage: json['startPage'] as int,
      endPage: json['endPage'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$_SummaryToJson(_$_Summary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'bookId': instance.bookId,
      'startPage': instance.startPage,
      'endPage': instance.endPage,
      'createdAt': instance.createdAt.toIso8601String(),
    };
