// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Book _$$_BookFromJson(Map<String, dynamic> json) => _$_Book(
      id: json['id'] as String,
      title: json['title'] as String,
      authors:
          (json['authors'] as List<dynamic>).map((e) => e as String?).toList(),
      imageLinks: json['imageLinks'] as Map<String, dynamic>,
      pageCount: json['pageCount'] as int,
    );

Map<String, dynamic> _$$_BookToJson(_$_Book instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'authors': instance.authors,
      'imageLinks': instance.imageLinks,
      'pageCount': instance.pageCount,
    };
