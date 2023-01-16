// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'google_book.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GoogleBook _$GoogleBookFromJson(Map<String, dynamic> json) {
  return _GoogleBook.fromJson(json);
}

/// @nodoc
mixin _$GoogleBook {
  String get id => throw _privateConstructorUsedError;
  Map<String, dynamic> get volumeInfo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GoogleBookCopyWith<GoogleBook> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoogleBookCopyWith<$Res> {
  factory $GoogleBookCopyWith(
          GoogleBook value, $Res Function(GoogleBook) then) =
      _$GoogleBookCopyWithImpl<$Res, GoogleBook>;
  @useResult
  $Res call({String id, Map<String, dynamic> volumeInfo});
}

/// @nodoc
class _$GoogleBookCopyWithImpl<$Res, $Val extends GoogleBook>
    implements $GoogleBookCopyWith<$Res> {
  _$GoogleBookCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? volumeInfo = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      volumeInfo: null == volumeInfo
          ? _value.volumeInfo
          : volumeInfo // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GoogleBookCopyWith<$Res>
    implements $GoogleBookCopyWith<$Res> {
  factory _$$_GoogleBookCopyWith(
          _$_GoogleBook value, $Res Function(_$_GoogleBook) then) =
      __$$_GoogleBookCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, Map<String, dynamic> volumeInfo});
}

/// @nodoc
class __$$_GoogleBookCopyWithImpl<$Res>
    extends _$GoogleBookCopyWithImpl<$Res, _$_GoogleBook>
    implements _$$_GoogleBookCopyWith<$Res> {
  __$$_GoogleBookCopyWithImpl(
      _$_GoogleBook _value, $Res Function(_$_GoogleBook) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? volumeInfo = null,
  }) {
    return _then(_$_GoogleBook(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      volumeInfo: null == volumeInfo
          ? _value._volumeInfo
          : volumeInfo // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GoogleBook implements _GoogleBook {
  const _$_GoogleBook(
      {required this.id, required final Map<String, dynamic> volumeInfo})
      : _volumeInfo = volumeInfo;

  factory _$_GoogleBook.fromJson(Map<String, dynamic> json) =>
      _$$_GoogleBookFromJson(json);

  @override
  final String id;
  final Map<String, dynamic> _volumeInfo;
  @override
  Map<String, dynamic> get volumeInfo {
    if (_volumeInfo is EqualUnmodifiableMapView) return _volumeInfo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_volumeInfo);
  }

  @override
  String toString() {
    return 'GoogleBook(id: $id, volumeInfo: $volumeInfo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GoogleBook &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality()
                .equals(other._volumeInfo, _volumeInfo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, const DeepCollectionEquality().hash(_volumeInfo));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GoogleBookCopyWith<_$_GoogleBook> get copyWith =>
      __$$_GoogleBookCopyWithImpl<_$_GoogleBook>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GoogleBookToJson(
      this,
    );
  }
}

abstract class _GoogleBook implements GoogleBook {
  const factory _GoogleBook(
      {required final String id,
      required final Map<String, dynamic> volumeInfo}) = _$_GoogleBook;

  factory _GoogleBook.fromJson(Map<String, dynamic> json) =
      _$_GoogleBook.fromJson;

  @override
  String get id;
  @override
  Map<String, dynamic> get volumeInfo;
  @override
  @JsonKey(ignore: true)
  _$$_GoogleBookCopyWith<_$_GoogleBook> get copyWith =>
      throw _privateConstructorUsedError;
}
