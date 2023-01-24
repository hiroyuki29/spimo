import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spimo/util/converter/string_to_color_conberter.dart';

part 'memo_text.freezed.dart';
part 'memo_text.g.dart';

@freezed
class MemoText with _$MemoText {
  MemoText._();
  const factory MemoText({
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
