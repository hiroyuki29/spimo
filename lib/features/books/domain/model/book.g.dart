// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Book _$$_BookFromJson(Map<String, dynamic> json) => _$_Book(
      id: json['id'] as String,
      title: json['title'] as String,
      authors:
          (json['authors'] as List<dynamic>?)?.map((e) => e as String).toList(),
      imageLinks: json['imageLinks'] as String?,
      pageCount: json['pageCount'] as int?,
      createdAt: const TimestampToDatetimeConverter()
          .fromJson(json['createdAt'] as Timestamp),
      totalMemoCount: json['totalMemoCount'] as int? ?? 0,
      memoList: (json['memoList'] as List<dynamic>?)
              ?.map((e) => Memo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_BookToJson(_$_Book instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'authors': instance.authors,
      'imageLinks': instance.imageLinks,
      'pageCount': instance.pageCount,
      'createdAt':
          const TimestampToDatetimeConverter().toJson(instance.createdAt),
      'totalMemoCount': instance.totalMemoCount,
      'memoList': instance.memoList,
    };
