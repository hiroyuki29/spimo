// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_books_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GoogleBooksApiResponse _$$_GoogleBooksApiResponseFromJson(
        Map<String, dynamic> json) =>
    _$_GoogleBooksApiResponse(
      kind: json['kind'] as String,
      totalItems: json['totalItems'] as int,
      items: (json['items'] as List<dynamic>)
          .map((e) => GoogleBook.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_GoogleBooksApiResponseToJson(
        _$_GoogleBooksApiResponse instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'totalItems': instance.totalItems,
      'items': instance.items,
    };
