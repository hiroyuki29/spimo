// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Book _$BookFromJson(Map<String, dynamic> json) {
  return _Book.fromJson(json);
}

/// @nodoc
mixin _$Book {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  List<String>? get authors => throw _privateConstructorUsedError;
  String? get imageLinks => throw _privateConstructorUsedError;
  int? get pageCount => throw _privateConstructorUsedError;
  @TimestampToDatetimeConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  int get totalMemoCount => throw _privateConstructorUsedError;
  List<Memo> get memoList => throw _privateConstructorUsedError;
  List<Summary> get summaryList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BookCopyWith<Book> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookCopyWith<$Res> {
  factory $BookCopyWith(Book value, $Res Function(Book) then) =
      _$BookCopyWithImpl<$Res, Book>;
  @useResult
  $Res call(
      {String id,
      String title,
      List<String>? authors,
      String? imageLinks,
      int? pageCount,
      @TimestampToDatetimeConverter() DateTime createdAt,
      int totalMemoCount,
      List<Memo> memoList,
      List<Summary> summaryList});
}

/// @nodoc
class _$BookCopyWithImpl<$Res, $Val extends Book>
    implements $BookCopyWith<$Res> {
  _$BookCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? authors = freezed,
    Object? imageLinks = freezed,
    Object? pageCount = freezed,
    Object? createdAt = null,
    Object? totalMemoCount = null,
    Object? memoList = null,
    Object? summaryList = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      authors: freezed == authors
          ? _value.authors
          : authors // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      imageLinks: freezed == imageLinks
          ? _value.imageLinks
          : imageLinks // ignore: cast_nullable_to_non_nullable
              as String?,
      pageCount: freezed == pageCount
          ? _value.pageCount
          : pageCount // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalMemoCount: null == totalMemoCount
          ? _value.totalMemoCount
          : totalMemoCount // ignore: cast_nullable_to_non_nullable
              as int,
      memoList: null == memoList
          ? _value.memoList
          : memoList // ignore: cast_nullable_to_non_nullable
              as List<Memo>,
      summaryList: null == summaryList
          ? _value.summaryList
          : summaryList // ignore: cast_nullable_to_non_nullable
              as List<Summary>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BookCopyWith<$Res> implements $BookCopyWith<$Res> {
  factory _$$_BookCopyWith(_$_Book value, $Res Function(_$_Book) then) =
      __$$_BookCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      List<String>? authors,
      String? imageLinks,
      int? pageCount,
      @TimestampToDatetimeConverter() DateTime createdAt,
      int totalMemoCount,
      List<Memo> memoList,
      List<Summary> summaryList});
}

/// @nodoc
class __$$_BookCopyWithImpl<$Res> extends _$BookCopyWithImpl<$Res, _$_Book>
    implements _$$_BookCopyWith<$Res> {
  __$$_BookCopyWithImpl(_$_Book _value, $Res Function(_$_Book) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? authors = freezed,
    Object? imageLinks = freezed,
    Object? pageCount = freezed,
    Object? createdAt = null,
    Object? totalMemoCount = null,
    Object? memoList = null,
    Object? summaryList = null,
  }) {
    return _then(_$_Book(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      authors: freezed == authors
          ? _value._authors
          : authors // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      imageLinks: freezed == imageLinks
          ? _value.imageLinks
          : imageLinks // ignore: cast_nullable_to_non_nullable
              as String?,
      pageCount: freezed == pageCount
          ? _value.pageCount
          : pageCount // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalMemoCount: null == totalMemoCount
          ? _value.totalMemoCount
          : totalMemoCount // ignore: cast_nullable_to_non_nullable
              as int,
      memoList: null == memoList
          ? _value._memoList
          : memoList // ignore: cast_nullable_to_non_nullable
              as List<Memo>,
      summaryList: null == summaryList
          ? _value._summaryList
          : summaryList // ignore: cast_nullable_to_non_nullable
              as List<Summary>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Book implements _Book {
  const _$_Book(
      {required this.id,
      required this.title,
      final List<String>? authors,
      this.imageLinks,
      this.pageCount,
      @TimestampToDatetimeConverter() required this.createdAt,
      this.totalMemoCount = 0,
      final List<Memo> memoList = const [],
      final List<Summary> summaryList = const []})
      : _authors = authors,
        _memoList = memoList,
        _summaryList = summaryList;

  factory _$_Book.fromJson(Map<String, dynamic> json) => _$$_BookFromJson(json);

  @override
  final String id;
  @override
  final String title;
  final List<String>? _authors;
  @override
  List<String>? get authors {
    final value = _authors;
    if (value == null) return null;
    if (_authors is EqualUnmodifiableListView) return _authors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? imageLinks;
  @override
  final int? pageCount;
  @override
  @TimestampToDatetimeConverter()
  final DateTime createdAt;
  @override
  @JsonKey()
  final int totalMemoCount;
  final List<Memo> _memoList;
  @override
  @JsonKey()
  List<Memo> get memoList {
    if (_memoList is EqualUnmodifiableListView) return _memoList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_memoList);
  }

  final List<Summary> _summaryList;
  @override
  @JsonKey()
  List<Summary> get summaryList {
    if (_summaryList is EqualUnmodifiableListView) return _summaryList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_summaryList);
  }

  @override
  String toString() {
    return 'Book(id: $id, title: $title, authors: $authors, imageLinks: $imageLinks, pageCount: $pageCount, createdAt: $createdAt, totalMemoCount: $totalMemoCount, memoList: $memoList, summaryList: $summaryList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Book &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._authors, _authors) &&
            (identical(other.imageLinks, imageLinks) ||
                other.imageLinks == imageLinks) &&
            (identical(other.pageCount, pageCount) ||
                other.pageCount == pageCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.totalMemoCount, totalMemoCount) ||
                other.totalMemoCount == totalMemoCount) &&
            const DeepCollectionEquality().equals(other._memoList, _memoList) &&
            const DeepCollectionEquality()
                .equals(other._summaryList, _summaryList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      const DeepCollectionEquality().hash(_authors),
      imageLinks,
      pageCount,
      createdAt,
      totalMemoCount,
      const DeepCollectionEquality().hash(_memoList),
      const DeepCollectionEquality().hash(_summaryList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BookCopyWith<_$_Book> get copyWith =>
      __$$_BookCopyWithImpl<_$_Book>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BookToJson(
      this,
    );
  }
}

abstract class _Book implements Book {
  const factory _Book(
      {required final String id,
      required final String title,
      final List<String>? authors,
      final String? imageLinks,
      final int? pageCount,
      @TimestampToDatetimeConverter() required final DateTime createdAt,
      final int totalMemoCount,
      final List<Memo> memoList,
      final List<Summary> summaryList}) = _$_Book;

  factory _Book.fromJson(Map<String, dynamic> json) = _$_Book.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  List<String>? get authors;
  @override
  String? get imageLinks;
  @override
  int? get pageCount;
  @override
  @TimestampToDatetimeConverter()
  DateTime get createdAt;
  @override
  int get totalMemoCount;
  @override
  List<Memo> get memoList;
  @override
  List<Summary> get summaryList;
  @override
  @JsonKey(ignore: true)
  _$$_BookCopyWith<_$_Book> get copyWith => throw _privateConstructorUsedError;
}
