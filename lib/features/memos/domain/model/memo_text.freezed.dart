// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'memo_text.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MemoText _$MemoTextFromJson(Map<String, dynamic> json) {
  return _MemoText.fromJson(json);
}

/// @nodoc
mixin _$MemoText {
  String get text => throw _privateConstructorUsedError;
  @StringToColorConverter()
  TextColor get textColor => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MemoTextCopyWith<MemoText> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MemoTextCopyWith<$Res> {
  factory $MemoTextCopyWith(MemoText value, $Res Function(MemoText) then) =
      _$MemoTextCopyWithImpl<$Res, MemoText>;
  @useResult
  $Res call({String text, @StringToColorConverter() TextColor textColor});
}

/// @nodoc
class _$MemoTextCopyWithImpl<$Res, $Val extends MemoText>
    implements $MemoTextCopyWith<$Res> {
  _$MemoTextCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? textColor = null,
  }) {
    return _then(_value.copyWith(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      textColor: null == textColor
          ? _value.textColor
          : textColor // ignore: cast_nullable_to_non_nullable
              as TextColor,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MemoTextCopyWith<$Res> implements $MemoTextCopyWith<$Res> {
  factory _$$_MemoTextCopyWith(
          _$_MemoText value, $Res Function(_$_MemoText) then) =
      __$$_MemoTextCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, @StringToColorConverter() TextColor textColor});
}

/// @nodoc
class __$$_MemoTextCopyWithImpl<$Res>
    extends _$MemoTextCopyWithImpl<$Res, _$_MemoText>
    implements _$$_MemoTextCopyWith<$Res> {
  __$$_MemoTextCopyWithImpl(
      _$_MemoText _value, $Res Function(_$_MemoText) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? textColor = null,
  }) {
    return _then(_$_MemoText(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      textColor: null == textColor
          ? _value.textColor
          : textColor // ignore: cast_nullable_to_non_nullable
              as TextColor,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MemoText extends _MemoText {
  _$_MemoText(
      {required this.text, @StringToColorConverter() required this.textColor})
      : super._();

  factory _$_MemoText.fromJson(Map<String, dynamic> json) =>
      _$$_MemoTextFromJson(json);

  @override
  final String text;
  @override
  @StringToColorConverter()
  final TextColor textColor;

  @override
  String toString() {
    return 'MemoText(text: $text, textColor: $textColor)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MemoText &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.textColor, textColor) ||
                other.textColor == textColor));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, text, textColor);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MemoTextCopyWith<_$_MemoText> get copyWith =>
      __$$_MemoTextCopyWithImpl<_$_MemoText>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MemoTextToJson(
      this,
    );
  }
}

abstract class _MemoText extends MemoText {
  factory _MemoText(
          {required final String text,
          @StringToColorConverter() required final TextColor textColor}) =
      _$_MemoText;
  _MemoText._() : super._();

  factory _MemoText.fromJson(Map<String, dynamic> json) = _$_MemoText.fromJson;

  @override
  String get text;
  @override
  @StringToColorConverter()
  TextColor get textColor;
  @override
  @JsonKey(ignore: true)
  _$$_MemoTextCopyWith<_$_MemoText> get copyWith =>
      throw _privateConstructorUsedError;
}
