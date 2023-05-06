// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'firestore_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FirestoreSummary _$FirestoreSummaryFromJson(Map<String, dynamic> json) {
  return _FirestoreSummary.fromJson(json);
}

/// @nodoc
mixin _$FirestoreSummary {
  String get id => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  String get bookId => throw _privateConstructorUsedError;
  int get startPage => throw _privateConstructorUsedError;
  int get endPage => throw _privateConstructorUsedError;
  @TimestampToDatetimeConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FirestoreSummaryCopyWith<FirestoreSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FirestoreSummaryCopyWith<$Res> {
  factory $FirestoreSummaryCopyWith(
          FirestoreSummary value, $Res Function(FirestoreSummary) then) =
      _$FirestoreSummaryCopyWithImpl<$Res, FirestoreSummary>;
  @useResult
  $Res call(
      {String id,
      String text,
      String bookId,
      int startPage,
      int endPage,
      @TimestampToDatetimeConverter() DateTime createdAt});
}

/// @nodoc
class _$FirestoreSummaryCopyWithImpl<$Res, $Val extends FirestoreSummary>
    implements $FirestoreSummaryCopyWith<$Res> {
  _$FirestoreSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? bookId = null,
    Object? startPage = null,
    Object? endPage = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      bookId: null == bookId
          ? _value.bookId
          : bookId // ignore: cast_nullable_to_non_nullable
              as String,
      startPage: null == startPage
          ? _value.startPage
          : startPage // ignore: cast_nullable_to_non_nullable
              as int,
      endPage: null == endPage
          ? _value.endPage
          : endPage // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FirestoreSummaryCopyWith<$Res>
    implements $FirestoreSummaryCopyWith<$Res> {
  factory _$$_FirestoreSummaryCopyWith(
          _$_FirestoreSummary value, $Res Function(_$_FirestoreSummary) then) =
      __$$_FirestoreSummaryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String text,
      String bookId,
      int startPage,
      int endPage,
      @TimestampToDatetimeConverter() DateTime createdAt});
}

/// @nodoc
class __$$_FirestoreSummaryCopyWithImpl<$Res>
    extends _$FirestoreSummaryCopyWithImpl<$Res, _$_FirestoreSummary>
    implements _$$_FirestoreSummaryCopyWith<$Res> {
  __$$_FirestoreSummaryCopyWithImpl(
      _$_FirestoreSummary _value, $Res Function(_$_FirestoreSummary) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? bookId = null,
    Object? startPage = null,
    Object? endPage = null,
    Object? createdAt = null,
  }) {
    return _then(_$_FirestoreSummary(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      bookId: null == bookId
          ? _value.bookId
          : bookId // ignore: cast_nullable_to_non_nullable
              as String,
      startPage: null == startPage
          ? _value.startPage
          : startPage // ignore: cast_nullable_to_non_nullable
              as int,
      endPage: null == endPage
          ? _value.endPage
          : endPage // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FirestoreSummary extends _FirestoreSummary {
  const _$_FirestoreSummary(
      {required this.id,
      required this.text,
      required this.bookId,
      required this.startPage,
      required this.endPage,
      @TimestampToDatetimeConverter() required this.createdAt})
      : super._();

  factory _$_FirestoreSummary.fromJson(Map<String, dynamic> json) =>
      _$$_FirestoreSummaryFromJson(json);

  @override
  final String id;
  @override
  final String text;
  @override
  final String bookId;
  @override
  final int startPage;
  @override
  final int endPage;
  @override
  @TimestampToDatetimeConverter()
  final DateTime createdAt;

  @override
  String toString() {
    return 'FirestoreSummary(id: $id, text: $text, bookId: $bookId, startPage: $startPage, endPage: $endPage, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FirestoreSummary &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.bookId, bookId) || other.bookId == bookId) &&
            (identical(other.startPage, startPage) ||
                other.startPage == startPage) &&
            (identical(other.endPage, endPage) || other.endPage == endPage) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, text, bookId, startPage, endPage, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FirestoreSummaryCopyWith<_$_FirestoreSummary> get copyWith =>
      __$$_FirestoreSummaryCopyWithImpl<_$_FirestoreSummary>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FirestoreSummaryToJson(
      this,
    );
  }
}

abstract class _FirestoreSummary extends FirestoreSummary {
  const factory _FirestoreSummary(
          {required final String id,
          required final String text,
          required final String bookId,
          required final int startPage,
          required final int endPage,
          @TimestampToDatetimeConverter() required final DateTime createdAt}) =
      _$_FirestoreSummary;
  const _FirestoreSummary._() : super._();

  factory _FirestoreSummary.fromJson(Map<String, dynamic> json) =
      _$_FirestoreSummary.fromJson;

  @override
  String get id;
  @override
  String get text;
  @override
  String get bookId;
  @override
  int get startPage;
  @override
  int get endPage;
  @override
  @TimestampToDatetimeConverter()
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$_FirestoreSummaryCopyWith<_$_FirestoreSummary> get copyWith =>
      throw _privateConstructorUsedError;
}
