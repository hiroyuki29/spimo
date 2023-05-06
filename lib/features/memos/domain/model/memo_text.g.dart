// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memo_text.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MemoText _$$_MemoTextFromJson(Map<String, dynamic> json) => _$_MemoText(
      text: json['text'] as String,
      textColor:
          const StringToColorConverter().fromJson(json['textColor'] as String),
    );

Map<String, dynamic> _$$_MemoTextToJson(_$_MemoText instance) =>
    <String, dynamic>{
      'text': instance.text,
      'textColor': const StringToColorConverter().toJson(instance.textColor),
    };
