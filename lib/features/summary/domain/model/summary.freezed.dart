// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Summary _$SummaryFromJson(Map<String, dynamic> json) {
  return _Summary.fromJson(json);
}

/// @nodoc
mixin _$Summary {
  String get id => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  String get bookId => throw _privateConstructorUsedError;
  int get startPage => throw _privateConstructorUsedError;
  int get endPage => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SummaryCopyWith<Summary> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SummaryCopyWith<$Res> {
  factory $SummaryCopyWith(Summary value, $Res Function(Summary) then) =
      _$SummaryCopyWithImpl<$Res, Summary>;
  @useResult
  $Res call(
      {String id,
      String text,
      String bookId,
      int startPage,
      int endPage,
      DateTime createdAt});
}

/// @nodoc
class _$SummaryCopyWithImpl<$Res, $Val extends Summary>
    implements $SummaryCopyWith<$Res> {
  _$SummaryCopyWithImpl(this._value, this._then);

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
abstract class _$$_SummaryCopyWith<$Res> implements $SummaryCopyWith<$Res> {
  factory _$$_SummaryCopyWith(
          _$_Summary value, $Res Function(_$_Summary) then) =
      __$$_SummaryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String text,
      String bookId,
      int startPage,
      int endPage,
      DateTime createdAt});
}

/// @nodoc
class __$$_SummaryCopyWithImpl<$Res>
    extends _$SummaryCopyWithImpl<$Res, _$_Summary>
    implements _$$_SummaryCopyWith<$Res> {
  __$$_SummaryCopyWithImpl(_$_Summary _value, $Res Function(_$_Summary) _then)
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
    return _then(_$_Summary(
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
class _$_Summary implements _Summary {
  const _$_Summary(
      {required this.id,
      required this.text,
      required this.bookId,
      required this.startPage,
      required this.endPage,
      required this.createdAt});

  factory _$_Summary.fromJson(Map<String, dynamic> json) =>
      _$$_SummaryFromJson(json);

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
  final DateTime createdAt;

  @override
  String toString() {
    return 'Summary(id: $id, text: $text, bookId: $bookId, startPage: $startPage, endPage: $endPage, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Summary &&
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
  _$$_SummaryCopyWith<_$_Summary> get copyWith =>
      __$$_SummaryCopyWithImpl<_$_Summary>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SummaryToJson(
      this,
    );
  }
}

abstract class _Summary implements Summary {
  const factory _Summary(
      {required final String id,
      required final String text,
      required final String bookId,
      required final int startPage,
      required final int endPage,
      required final DateTime createdAt}) = _$_Summary;

  factory _Summary.fromJson(Map<String, dynamic> json) = _$_Summary.fromJson;

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
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$_SummaryCopyWith<_$_Summary> get copyWith =>
      throw _privateConstructorUsedError;
}
