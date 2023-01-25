import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spimo/util/converter/string_to_color_conberter.dart';

part 'memo_text.freezed.dart';
part 'memo_text.g.dart';

@freezed
class MemoText with _$MemoText {
  const MemoText._();
  factory MemoText({
    required String text,
    @StringToColorConverter() required TextColor textColor,
  }) = _MemoText;

  factory MemoText.fromJson(Map<String, dynamic> json) =>
      _$MemoTextFromJson(json);

  @override
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'textColor': textColor.name,
    };
  }
}

enum TextColor {
  black(color: Colors.black),
  red(color: Colors.red);

  const TextColor({required this.color});

  final Color color;

  factory TextColor.fromString(String? text) {
    switch (text) {
      case 'black':
        return TextColor.black;
      case 'red':
        return TextColor.red;
      default:
        return TextColor.black;
    }
  }
}
