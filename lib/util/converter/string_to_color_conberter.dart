import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spimo/features/memos/domain/model/memo_text.dart';

class StringToColorConverter implements JsonConverter<TextColor, String> {
  const StringToColorConverter();

  @override
  TextColor fromJson(String json) => TextColor.fromString(json);

  @override
  String toJson(TextColor textColor) => textColor.name;
}
