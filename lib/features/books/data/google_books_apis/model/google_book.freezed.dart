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
  VolumeInfo get volumeInfo => throw _privateConstructorUsedError;

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
  $Res call({String id, VolumeInfo volumeInfo});

  $VolumeInfoCopyWith<$Res> get volumeInfo;
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
              as VolumeInfo,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $VolumeInfoCopyWith<$Res> get volumeInfo {
    return $VolumeInfoCopyWith<$Res>(_value.volumeInfo, (value) {
      return _then(_value.copyWith(volumeInfo: value) as $Val);
    });
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
  $Res call({String id, VolumeInfo volumeInfo});

  @override
  $VolumeInfoCopyWith<$Res> get volumeInfo;
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
          ? _value.volumeInfo
          : volumeInfo // ignore: cast_nullable_to_non_nullable
              as VolumeInfo,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GoogleBook extends _GoogleBook {
  const _$_GoogleBook({required this.id, required this.volumeInfo}) : super._();

  factory _$_GoogleBook.fromJson(Map<String, dynamic> json) =>
      _$$_GoogleBookFromJson(json);

  @override
  final String id;
  @override
  final VolumeInfo volumeInfo;

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
            (identical(other.volumeInfo, volumeInfo) ||
                other.volumeInfo == volumeInfo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, volumeInfo);

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

abstract class _GoogleBook extends GoogleBook {
  const factory _GoogleBook(
      {required final String id,
      required final VolumeInfo volumeInfo}) = _$_GoogleBook;
  const _GoogleBook._() : super._();

  factory _GoogleBook.fromJson(Map<String, dynamic> json) =
      _$_GoogleBook.fromJson;

  @override
  String get id;
  @override
  VolumeInfo get volumeInfo;
  @override
  @JsonKey(ignore: true)
  _$$_GoogleBookCopyWith<_$_GoogleBook> get copyWith =>
      throw _privateConstructorUsedError;
}
