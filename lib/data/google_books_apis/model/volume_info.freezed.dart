// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'volume_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

VolumeInfo _$VolumeInfoFromJson(Map<String, dynamic> json) {
  return _VolumeInfo.fromJson(json);
}

/// @nodoc
mixin _$VolumeInfo {
  String get title => throw _privateConstructorUsedError;
  List<String>? get authors => throw _privateConstructorUsedError;
  int? get pageCount => throw _privateConstructorUsedError;
  ImageLinks? get imageLinks => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VolumeInfoCopyWith<VolumeInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VolumeInfoCopyWith<$Res> {
  factory $VolumeInfoCopyWith(
          VolumeInfo value, $Res Function(VolumeInfo) then) =
      _$VolumeInfoCopyWithImpl<$Res, VolumeInfo>;
  @useResult
  $Res call(
      {String title,
      List<String>? authors,
      int? pageCount,
      ImageLinks? imageLinks});

  $ImageLinksCopyWith<$Res>? get imageLinks;
}

/// @nodoc
class _$VolumeInfoCopyWithImpl<$Res, $Val extends VolumeInfo>
    implements $VolumeInfoCopyWith<$Res> {
  _$VolumeInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? authors = freezed,
    Object? pageCount = freezed,
    Object? imageLinks = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      authors: freezed == authors
          ? _value.authors
          : authors // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      pageCount: freezed == pageCount
          ? _value.pageCount
          : pageCount // ignore: cast_nullable_to_non_nullable
              as int?,
      imageLinks: freezed == imageLinks
          ? _value.imageLinks
          : imageLinks // ignore: cast_nullable_to_non_nullable
              as ImageLinks?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ImageLinksCopyWith<$Res>? get imageLinks {
    if (_value.imageLinks == null) {
      return null;
    }

    return $ImageLinksCopyWith<$Res>(_value.imageLinks!, (value) {
      return _then(_value.copyWith(imageLinks: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_VolumeInfoCopyWith<$Res>
    implements $VolumeInfoCopyWith<$Res> {
  factory _$$_VolumeInfoCopyWith(
          _$_VolumeInfo value, $Res Function(_$_VolumeInfo) then) =
      __$$_VolumeInfoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      List<String>? authors,
      int? pageCount,
      ImageLinks? imageLinks});

  @override
  $ImageLinksCopyWith<$Res>? get imageLinks;
}

/// @nodoc
class __$$_VolumeInfoCopyWithImpl<$Res>
    extends _$VolumeInfoCopyWithImpl<$Res, _$_VolumeInfo>
    implements _$$_VolumeInfoCopyWith<$Res> {
  __$$_VolumeInfoCopyWithImpl(
      _$_VolumeInfo _value, $Res Function(_$_VolumeInfo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? authors = freezed,
    Object? pageCount = freezed,
    Object? imageLinks = freezed,
  }) {
    return _then(_$_VolumeInfo(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      authors: freezed == authors
          ? _value._authors
          : authors // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      pageCount: freezed == pageCount
          ? _value.pageCount
          : pageCount // ignore: cast_nullable_to_non_nullable
              as int?,
      imageLinks: freezed == imageLinks
          ? _value.imageLinks
          : imageLinks // ignore: cast_nullable_to_non_nullable
              as ImageLinks?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_VolumeInfo implements _VolumeInfo {
  const _$_VolumeInfo(
      {required this.title,
      final List<String>? authors,
      this.pageCount,
      this.imageLinks})
      : _authors = authors;

  factory _$_VolumeInfo.fromJson(Map<String, dynamic> json) =>
      _$$_VolumeInfoFromJson(json);

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
  final int? pageCount;
  @override
  final ImageLinks? imageLinks;

  @override
  String toString() {
    return 'VolumeInfo(title: $title, authors: $authors, pageCount: $pageCount, imageLinks: $imageLinks)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VolumeInfo &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._authors, _authors) &&
            (identical(other.pageCount, pageCount) ||
                other.pageCount == pageCount) &&
            (identical(other.imageLinks, imageLinks) ||
                other.imageLinks == imageLinks));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title,
      const DeepCollectionEquality().hash(_authors), pageCount, imageLinks);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_VolumeInfoCopyWith<_$_VolumeInfo> get copyWith =>
      __$$_VolumeInfoCopyWithImpl<_$_VolumeInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_VolumeInfoToJson(
      this,
    );
  }
}

abstract class _VolumeInfo implements VolumeInfo {
  const factory _VolumeInfo(
      {required final String title,
      final List<String>? authors,
      final int? pageCount,
      final ImageLinks? imageLinks}) = _$_VolumeInfo;

  factory _VolumeInfo.fromJson(Map<String, dynamic> json) =
      _$_VolumeInfo.fromJson;

  @override
  String get title;
  @override
  List<String>? get authors;
  @override
  int? get pageCount;
  @override
  ImageLinks? get imageLinks;
  @override
  @JsonKey(ignore: true)
  _$$_VolumeInfoCopyWith<_$_VolumeInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
