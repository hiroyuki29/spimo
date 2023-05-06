// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'firestore_memo_length_stock.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FirestoreMemoLengthStock _$FirestoreMemoLengthStockFromJson(
    Map<String, dynamic> json) {
  return _FirestoreMemoLengthStock.fromJson(json);
}

/// @nodoc
mixin _$FirestoreMemoLengthStock {
  int get memoLength => throw _privateConstructorUsedError;
  @TimestampToDatetimeConverter()
  DateTime get date => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FirestoreMemoLengthStockCopyWith<FirestoreMemoLengthStock> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FirestoreMemoLengthStockCopyWith<$Res> {
  factory $FirestoreMemoLengthStockCopyWith(FirestoreMemoLengthStock value,
          $Res Function(FirestoreMemoLengthStock) then) =
      _$FirestoreMemoLengthStockCopyWithImpl<$Res, FirestoreMemoLengthStock>;
  @useResult
  $Res call({int memoLength, @TimestampToDatetimeConverter() DateTime date});
}

/// @nodoc
class _$FirestoreMemoLengthStockCopyWithImpl<$Res,
        $Val extends FirestoreMemoLengthStock>
    implements $FirestoreMemoLengthStockCopyWith<$Res> {
  _$FirestoreMemoLengthStockCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memoLength = null,
    Object? date = null,
  }) {
    return _then(_value.copyWith(
      memoLength: null == memoLength
          ? _value.memoLength
          : memoLength // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FirestoreMemoLengthStockCopyWith<$Res>
    implements $FirestoreMemoLengthStockCopyWith<$Res> {
  factory _$$_FirestoreMemoLengthStockCopyWith(
          _$_FirestoreMemoLengthStock value,
          $Res Function(_$_FirestoreMemoLengthStock) then) =
      __$$_FirestoreMemoLengthStockCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int memoLength, @TimestampToDatetimeConverter() DateTime date});
}

/// @nodoc
class __$$_FirestoreMemoLengthStockCopyWithImpl<$Res>
    extends _$FirestoreMemoLengthStockCopyWithImpl<$Res,
        _$_FirestoreMemoLengthStock>
    implements _$$_FirestoreMemoLengthStockCopyWith<$Res> {
  __$$_FirestoreMemoLengthStockCopyWithImpl(_$_FirestoreMemoLengthStock _value,
      $Res Function(_$_FirestoreMemoLengthStock) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memoLength = null,
    Object? date = null,
  }) {
    return _then(_$_FirestoreMemoLengthStock(
      memoLength: null == memoLength
          ? _value.memoLength
          : memoLength // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FirestoreMemoLengthStock extends _FirestoreMemoLengthStock {
  const _$_FirestoreMemoLengthStock(
      {required this.memoLength,
      @TimestampToDatetimeConverter() required this.date})
      : super._();

  factory _$_FirestoreMemoLengthStock.fromJson(Map<String, dynamic> json) =>
      _$$_FirestoreMemoLengthStockFromJson(json);

  @override
  final int memoLength;
  @override
  @TimestampToDatetimeConverter()
  final DateTime date;

  @override
  String toString() {
    return 'FirestoreMemoLengthStock(memoLength: $memoLength, date: $date)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FirestoreMemoLengthStock &&
            (identical(other.memoLength, memoLength) ||
                other.memoLength == memoLength) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, memoLength, date);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FirestoreMemoLengthStockCopyWith<_$_FirestoreMemoLengthStock>
      get copyWith => __$$_FirestoreMemoLengthStockCopyWithImpl<
          _$_FirestoreMemoLengthStock>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FirestoreMemoLengthStockToJson(
      this,
    );
  }
}

abstract class _FirestoreMemoLengthStock extends FirestoreMemoLengthStock {
  const factory _FirestoreMemoLengthStock(
          {required final int memoLength,
          @TimestampToDatetimeConverter() required final DateTime date}) =
      _$_FirestoreMemoLengthStock;
  const _FirestoreMemoLengthStock._() : super._();

  factory _FirestoreMemoLengthStock.fromJson(Map<String, dynamic> json) =
      _$_FirestoreMemoLengthStock.fromJson;

  @override
  int get memoLength;
  @override
  @TimestampToDatetimeConverter()
  DateTime get date;
  @override
  @JsonKey(ignore: true)
  _$$_FirestoreMemoLengthStockCopyWith<_$_FirestoreMemoLengthStock>
      get copyWith => throw _privateConstructorUsedError;
}
