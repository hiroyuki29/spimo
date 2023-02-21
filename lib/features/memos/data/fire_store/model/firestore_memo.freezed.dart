// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'firestore_memo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FirestoreMemo _$FirestoreMemoFromJson(Map<String, dynamic> json) {
  return _FirestoreMemo.fromJson(json);
}

/// @nodoc
mixin _$FirestoreMemo {
  String get id => throw _privateConstructorUsedError;
  List<MemoText> get contents => throw _privateConstructorUsedError;
  String get bookId => throw _privateConstructorUsedError;
  int? get startPage => throw _privateConstructorUsedError;
  int? get endPage => throw _privateConstructorUsedError;
  @TimestampToDatetimeConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FirestoreMemoCopyWith<FirestoreMemo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FirestoreMemoCopyWith<$Res> {
  factory $FirestoreMemoCopyWith(
          FirestoreMemo value, $Res Function(FirestoreMemo) then) =
      _$FirestoreMemoCopyWithImpl<$Res, FirestoreMemo>;
  @useResult
  $Res call(
      {String id,
      List<MemoText> contents,
      String bookId,
      int? startPage,
      int? endPage,
      @TimestampToDatetimeConverter() DateTime createdAt});
}

/// @nodoc
class _$FirestoreMemoCopyWithImpl<$Res, $Val extends FirestoreMemo>
    implements $FirestoreMemoCopyWith<$Res> {
  _$FirestoreMemoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? contents = null,
    Object? bookId = null,
    Object? startPage = freezed,
    Object? endPage = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      contents: null == contents
          ? _value.contents
          : contents // ignore: cast_nullable_to_non_nullable
              as List<MemoText>,
      bookId: null == bookId
          ? _value.bookId
          : bookId // ignore: cast_nullable_to_non_nullable
              as String,
      startPage: freezed == startPage
          ? _value.startPage
          : startPage // ignore: cast_nullable_to_non_nullable
              as int?,
      endPage: freezed == endPage
          ? _value.endPage
          : endPage // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FirestoreMemoCopyWith<$Res>
    implements $FirestoreMemoCopyWith<$Res> {
  factory _$$_FirestoreMemoCopyWith(
          _$_FirestoreMemo value, $Res Function(_$_FirestoreMemo) then) =
      __$$_FirestoreMemoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      List<MemoText> contents,
      String bookId,
      int? startPage,
      int? endPage,
      @TimestampToDatetimeConverter() DateTime createdAt});
}

/// @nodoc
class __$$_FirestoreMemoCopyWithImpl<$Res>
    extends _$FirestoreMemoCopyWithImpl<$Res, _$_FirestoreMemo>
    implements _$$_FirestoreMemoCopyWith<$Res> {
  __$$_FirestoreMemoCopyWithImpl(
      _$_FirestoreMemo _value, $Res Function(_$_FirestoreMemo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? contents = null,
    Object? bookId = null,
    Object? startPage = freezed,
    Object? endPage = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$_FirestoreMemo(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      contents: null == contents
          ? _value._contents
          : contents // ignore: cast_nullable_to_non_nullable
              as List<MemoText>,
      bookId: null == bookId
          ? _value.bookId
          : bookId // ignore: cast_nullable_to_non_nullable
              as String,
      startPage: freezed == startPage
          ? _value.startPage
          : startPage // ignore: cast_nullable_to_non_nullable
              as int?,
      endPage: freezed == endPage
          ? _value.endPage
          : endPage // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FirestoreMemo extends _FirestoreMemo {
  const _$_FirestoreMemo(
      {required this.id,
      required final List<MemoText> contents,
      required this.bookId,
      this.startPage,
      this.endPage,
      @TimestampToDatetimeConverter() required this.createdAt})
      : _contents = contents,
        super._();

  factory _$_FirestoreMemo.fromJson(Map<String, dynamic> json) =>
      _$$_FirestoreMemoFromJson(json);

  @override
  final String id;
  final List<MemoText> _contents;
  @override
  List<MemoText> get contents {
    if (_contents is EqualUnmodifiableListView) return _contents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contents);
  }

  @override
  final String bookId;
  @override
  final int? startPage;
  @override
  final int? endPage;
  @override
  @TimestampToDatetimeConverter()
  final DateTime createdAt;

  @override
  String toString() {
    return 'FirestoreMemo(id: $id, contents: $contents, bookId: $bookId, startPage: $startPage, endPage: $endPage, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FirestoreMemo &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._contents, _contents) &&
            (identical(other.bookId, bookId) || other.bookId == bookId) &&
            (identical(other.startPage, startPage) ||
                other.startPage == startPage) &&
            (identical(other.endPage, endPage) || other.endPage == endPage) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      const DeepCollectionEquality().hash(_contents),
      bookId,
      startPage,
      endPage,
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FirestoreMemoCopyWith<_$_FirestoreMemo> get copyWith =>
      __$$_FirestoreMemoCopyWithImpl<_$_FirestoreMemo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FirestoreMemoToJson(
      this,
    );
  }
}

abstract class _FirestoreMemo extends FirestoreMemo {
  const factory _FirestoreMemo(
          {required final String id,
          required final List<MemoText> contents,
          required final String bookId,
          final int? startPage,
          final int? endPage,
          @TimestampToDatetimeConverter() required final DateTime createdAt}) =
      _$_FirestoreMemo;
  const _FirestoreMemo._() : super._();

  factory _FirestoreMemo.fromJson(Map<String, dynamic> json) =
      _$_FirestoreMemo.fromJson;

  @override
  String get id;
  @override
  List<MemoText> get contents;
  @override
  String get bookId;
  @override
  int? get startPage;
  @override
  int? get endPage;
  @override
  @TimestampToDatetimeConverter()
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$_FirestoreMemoCopyWith<_$_FirestoreMemo> get copyWith =>
      throw _privateConstructorUsedError;
}
