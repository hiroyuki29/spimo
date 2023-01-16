// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'google_books_api_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GoogleBooksApiResponse _$GoogleBooksApiResponseFromJson(
    Map<String, dynamic> json) {
  return _GoogleBooksApiResponse.fromJson(json);
}

/// @nodoc
mixin _$GoogleBooksApiResponse {
  String get kind => throw _privateConstructorUsedError;
  int get totalItems => throw _privateConstructorUsedError;
  List<GoogleBook> get items => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GoogleBooksApiResponseCopyWith<GoogleBooksApiResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoogleBooksApiResponseCopyWith<$Res> {
  factory $GoogleBooksApiResponseCopyWith(GoogleBooksApiResponse value,
          $Res Function(GoogleBooksApiResponse) then) =
      _$GoogleBooksApiResponseCopyWithImpl<$Res, GoogleBooksApiResponse>;
  @useResult
  $Res call({String kind, int totalItems, List<GoogleBook> items});
}

/// @nodoc
class _$GoogleBooksApiResponseCopyWithImpl<$Res,
        $Val extends GoogleBooksApiResponse>
    implements $GoogleBooksApiResponseCopyWith<$Res> {
  _$GoogleBooksApiResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? kind = null,
    Object? totalItems = null,
    Object? items = null,
  }) {
    return _then(_value.copyWith(
      kind: null == kind
          ? _value.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as String,
      totalItems: null == totalItems
          ? _value.totalItems
          : totalItems // ignore: cast_nullable_to_non_nullable
              as int,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<GoogleBook>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GoogleBooksApiResponseCopyWith<$Res>
    implements $GoogleBooksApiResponseCopyWith<$Res> {
  factory _$$_GoogleBooksApiResponseCopyWith(_$_GoogleBooksApiResponse value,
          $Res Function(_$_GoogleBooksApiResponse) then) =
      __$$_GoogleBooksApiResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String kind, int totalItems, List<GoogleBook> items});
}

/// @nodoc
class __$$_GoogleBooksApiResponseCopyWithImpl<$Res>
    extends _$GoogleBooksApiResponseCopyWithImpl<$Res,
        _$_GoogleBooksApiResponse>
    implements _$$_GoogleBooksApiResponseCopyWith<$Res> {
  __$$_GoogleBooksApiResponseCopyWithImpl(_$_GoogleBooksApiResponse _value,
      $Res Function(_$_GoogleBooksApiResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? kind = null,
    Object? totalItems = null,
    Object? items = null,
  }) {
    return _then(_$_GoogleBooksApiResponse(
      kind: null == kind
          ? _value.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as String,
      totalItems: null == totalItems
          ? _value.totalItems
          : totalItems // ignore: cast_nullable_to_non_nullable
              as int,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<GoogleBook>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GoogleBooksApiResponse implements _GoogleBooksApiResponse {
  const _$_GoogleBooksApiResponse(
      {required this.kind,
      required this.totalItems,
      required final List<GoogleBook> items})
      : _items = items;

  factory _$_GoogleBooksApiResponse.fromJson(Map<String, dynamic> json) =>
      _$$_GoogleBooksApiResponseFromJson(json);

  @override
  final String kind;
  @override
  final int totalItems;
  final List<GoogleBook> _items;
  @override
  List<GoogleBook> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'GoogleBooksApiResponse(kind: $kind, totalItems: $totalItems, items: $items)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GoogleBooksApiResponse &&
            (identical(other.kind, kind) || other.kind == kind) &&
            (identical(other.totalItems, totalItems) ||
                other.totalItems == totalItems) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, kind, totalItems,
      const DeepCollectionEquality().hash(_items));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GoogleBooksApiResponseCopyWith<_$_GoogleBooksApiResponse> get copyWith =>
      __$$_GoogleBooksApiResponseCopyWithImpl<_$_GoogleBooksApiResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GoogleBooksApiResponseToJson(
      this,
    );
  }
}

abstract class _GoogleBooksApiResponse implements GoogleBooksApiResponse {
  const factory _GoogleBooksApiResponse(
      {required final String kind,
      required final int totalItems,
      required final List<GoogleBook> items}) = _$_GoogleBooksApiResponse;

  factory _GoogleBooksApiResponse.fromJson(Map<String, dynamic> json) =
      _$_GoogleBooksApiResponse.fromJson;

  @override
  String get kind;
  @override
  int get totalItems;
  @override
  List<GoogleBook> get items;
  @override
  @JsonKey(ignore: true)
  _$$_GoogleBooksApiResponseCopyWith<_$_GoogleBooksApiResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
