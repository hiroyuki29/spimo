import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class StringToColorConverter implements JsonConverter<TextColor, String> {
  const StringToColorConverter();

  @override
  TextColor fromJson(String json) => TextColor.fromString(json);

  @override
  String toJson(TextColor textColor) => textColor.name;
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
