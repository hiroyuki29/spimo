// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Memo _$$_MemoFromJson(Map<String, dynamic> json) => _$_Memo(
      memos: (json['memos'] as List<dynamic>).map((e) => e as String).toList(),
      startPage: json['startPage'] as int,
      endPage: json['endPage'] as int?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$_MemoToJson(_$_Memo instance) => <String, dynamic>{
      'memos': instance.memos,
      'startPage': instance.startPage,
      'endPage': instance.endPage,
      'createdAt': instance.createdAt.toIso8601String(),
    };
