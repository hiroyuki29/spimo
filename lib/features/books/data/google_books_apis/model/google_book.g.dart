// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GoogleBook _$$_GoogleBookFromJson(Map<String, dynamic> json) =>
    _$_GoogleBook(
      id: json['id'] as String,
      volumeInfo:
          VolumeInfo.fromJson(json['volumeInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_GoogleBookToJson(_$_GoogleBook instance) =>
    <String, dynamic>{
      'id': instance.id,
      'volumeInfo': instance.volumeInfo,
    };
