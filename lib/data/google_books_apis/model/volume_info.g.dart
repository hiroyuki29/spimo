// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'volume_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_VolumeInfo _$$_VolumeInfoFromJson(Map<String, dynamic> json) =>
    _$_VolumeInfo(
      title: json['title'] as String,
      authors:
          (json['authors'] as List<dynamic>?)?.map((e) => e as String).toList(),
      pageCount: json['pageCount'] as int?,
      imageLinks: json['imageLinks'] == null
          ? null
          : ImageLinks.fromJson(json['imageLinks'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_VolumeInfoToJson(_$_VolumeInfo instance) =>
    <String, dynamic>{
      'title': instance.title,
      'authors': instance.authors,
      'pageCount': instance.pageCount,
      'imageLinks': instance.imageLinks,
    };
