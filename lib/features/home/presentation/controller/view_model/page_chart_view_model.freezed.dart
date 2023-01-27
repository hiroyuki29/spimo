// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'page_chart_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PageChartViewModel {
  List<FlSpot> get chartPointsAll => throw _privateConstructorUsedError;
  List<FlSpot> get chartPointsOnlyRed => throw _privateConstructorUsedError;
  int get pageCount => throw _privateConstructorUsedError;
  double get maxWordLength => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PageChartViewModelCopyWith<PageChartViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PageChartViewModelCopyWith<$Res> {
  factory $PageChartViewModelCopyWith(
          PageChartViewModel value, $Res Function(PageChartViewModel) then) =
      _$PageChartViewModelCopyWithImpl<$Res, PageChartViewModel>;
  @useResult
  $Res call(
      {List<FlSpot> chartPointsAll,
      List<FlSpot> chartPointsOnlyRed,
      int pageCount,
      double maxWordLength});
}

/// @nodoc
class _$PageChartViewModelCopyWithImpl<$Res, $Val extends PageChartViewModel>
    implements $PageChartViewModelCopyWith<$Res> {
  _$PageChartViewModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chartPointsAll = null,
    Object? chartPointsOnlyRed = null,
    Object? pageCount = null,
    Object? maxWordLength = null,
  }) {
    return _then(_value.copyWith(
      chartPointsAll: null == chartPointsAll
          ? _value.chartPointsAll
          : chartPointsAll // ignore: cast_nullable_to_non_nullable
              as List<FlSpot>,
      chartPointsOnlyRed: null == chartPointsOnlyRed
          ? _value.chartPointsOnlyRed
          : chartPointsOnlyRed // ignore: cast_nullable_to_non_nullable
              as List<FlSpot>,
      pageCount: null == pageCount
          ? _value.pageCount
          : pageCount // ignore: cast_nullable_to_non_nullable
              as int,
      maxWordLength: null == maxWordLength
          ? _value.maxWordLength
          : maxWordLength // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PageChartViewModelCopyWith<$Res>
    implements $PageChartViewModelCopyWith<$Res> {
  factory _$$_PageChartViewModelCopyWith(_$_PageChartViewModel value,
          $Res Function(_$_PageChartViewModel) then) =
      __$$_PageChartViewModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<FlSpot> chartPointsAll,
      List<FlSpot> chartPointsOnlyRed,
      int pageCount,
      double maxWordLength});
}

/// @nodoc
class __$$_PageChartViewModelCopyWithImpl<$Res>
    extends _$PageChartViewModelCopyWithImpl<$Res, _$_PageChartViewModel>
    implements _$$_PageChartViewModelCopyWith<$Res> {
  __$$_PageChartViewModelCopyWithImpl(
      _$_PageChartViewModel _value, $Res Function(_$_PageChartViewModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chartPointsAll = null,
    Object? chartPointsOnlyRed = null,
    Object? pageCount = null,
    Object? maxWordLength = null,
  }) {
    return _then(_$_PageChartViewModel(
      chartPointsAll: null == chartPointsAll
          ? _value._chartPointsAll
          : chartPointsAll // ignore: cast_nullable_to_non_nullable
              as List<FlSpot>,
      chartPointsOnlyRed: null == chartPointsOnlyRed
          ? _value._chartPointsOnlyRed
          : chartPointsOnlyRed // ignore: cast_nullable_to_non_nullable
              as List<FlSpot>,
      pageCount: null == pageCount
          ? _value.pageCount
          : pageCount // ignore: cast_nullable_to_non_nullable
              as int,
      maxWordLength: null == maxWordLength
          ? _value.maxWordLength
          : maxWordLength // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$_PageChartViewModel implements _PageChartViewModel {
  const _$_PageChartViewModel(
      {required final List<FlSpot> chartPointsAll,
      required final List<FlSpot> chartPointsOnlyRed,
      required this.pageCount,
      required this.maxWordLength})
      : _chartPointsAll = chartPointsAll,
        _chartPointsOnlyRed = chartPointsOnlyRed;

  final List<FlSpot> _chartPointsAll;
  @override
  List<FlSpot> get chartPointsAll {
    if (_chartPointsAll is EqualUnmodifiableListView) return _chartPointsAll;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chartPointsAll);
  }

  final List<FlSpot> _chartPointsOnlyRed;
  @override
  List<FlSpot> get chartPointsOnlyRed {
    if (_chartPointsOnlyRed is EqualUnmodifiableListView)
      return _chartPointsOnlyRed;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chartPointsOnlyRed);
  }

  @override
  final int pageCount;
  @override
  final double maxWordLength;

  @override
  String toString() {
    return 'PageChartViewModel(chartPointsAll: $chartPointsAll, chartPointsOnlyRed: $chartPointsOnlyRed, pageCount: $pageCount, maxWordLength: $maxWordLength)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PageChartViewModel &&
            const DeepCollectionEquality()
                .equals(other._chartPointsAll, _chartPointsAll) &&
            const DeepCollectionEquality()
                .equals(other._chartPointsOnlyRed, _chartPointsOnlyRed) &&
            (identical(other.pageCount, pageCount) ||
                other.pageCount == pageCount) &&
            (identical(other.maxWordLength, maxWordLength) ||
                other.maxWordLength == maxWordLength));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_chartPointsAll),
      const DeepCollectionEquality().hash(_chartPointsOnlyRed),
      pageCount,
      maxWordLength);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PageChartViewModelCopyWith<_$_PageChartViewModel> get copyWith =>
      __$$_PageChartViewModelCopyWithImpl<_$_PageChartViewModel>(
          this, _$identity);
}

abstract class _PageChartViewModel implements PageChartViewModel {
  const factory _PageChartViewModel(
      {required final List<FlSpot> chartPointsAll,
      required final List<FlSpot> chartPointsOnlyRed,
      required final int pageCount,
      required final double maxWordLength}) = _$_PageChartViewModel;

  @override
  List<FlSpot> get chartPointsAll;
  @override
  List<FlSpot> get chartPointsOnlyRed;
  @override
  int get pageCount;
  @override
  double get maxWordLength;
  @override
  @JsonKey(ignore: true)
  _$$_PageChartViewModelCopyWith<_$_PageChartViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}
