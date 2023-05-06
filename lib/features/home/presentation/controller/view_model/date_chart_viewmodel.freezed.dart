// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'date_chart_viewmodel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DateChartViewModel {
  List<FlSpot> get chartPointsAll => throw _privateConstructorUsedError;
  double get allDaysDuration => throw _privateConstructorUsedError;
  double get maxWordLength => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DateChartViewModelCopyWith<DateChartViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DateChartViewModelCopyWith<$Res> {
  factory $DateChartViewModelCopyWith(
          DateChartViewModel value, $Res Function(DateChartViewModel) then) =
      _$DateChartViewModelCopyWithImpl<$Res, DateChartViewModel>;
  @useResult
  $Res call(
      {List<FlSpot> chartPointsAll,
      double allDaysDuration,
      double maxWordLength});
}

/// @nodoc
class _$DateChartViewModelCopyWithImpl<$Res, $Val extends DateChartViewModel>
    implements $DateChartViewModelCopyWith<$Res> {
  _$DateChartViewModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chartPointsAll = null,
    Object? allDaysDuration = null,
    Object? maxWordLength = null,
  }) {
    return _then(_value.copyWith(
      chartPointsAll: null == chartPointsAll
          ? _value.chartPointsAll
          : chartPointsAll // ignore: cast_nullable_to_non_nullable
              as List<FlSpot>,
      allDaysDuration: null == allDaysDuration
          ? _value.allDaysDuration
          : allDaysDuration // ignore: cast_nullable_to_non_nullable
              as double,
      maxWordLength: null == maxWordLength
          ? _value.maxWordLength
          : maxWordLength // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DateChartViewModelCopyWith<$Res>
    implements $DateChartViewModelCopyWith<$Res> {
  factory _$$_DateChartViewModelCopyWith(_$_DateChartViewModel value,
          $Res Function(_$_DateChartViewModel) then) =
      __$$_DateChartViewModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<FlSpot> chartPointsAll,
      double allDaysDuration,
      double maxWordLength});
}

/// @nodoc
class __$$_DateChartViewModelCopyWithImpl<$Res>
    extends _$DateChartViewModelCopyWithImpl<$Res, _$_DateChartViewModel>
    implements _$$_DateChartViewModelCopyWith<$Res> {
  __$$_DateChartViewModelCopyWithImpl(
      _$_DateChartViewModel _value, $Res Function(_$_DateChartViewModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chartPointsAll = null,
    Object? allDaysDuration = null,
    Object? maxWordLength = null,
  }) {
    return _then(_$_DateChartViewModel(
      chartPointsAll: null == chartPointsAll
          ? _value._chartPointsAll
          : chartPointsAll // ignore: cast_nullable_to_non_nullable
              as List<FlSpot>,
      allDaysDuration: null == allDaysDuration
          ? _value.allDaysDuration
          : allDaysDuration // ignore: cast_nullable_to_non_nullable
              as double,
      maxWordLength: null == maxWordLength
          ? _value.maxWordLength
          : maxWordLength // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$_DateChartViewModel implements _DateChartViewModel {
  const _$_DateChartViewModel(
      {required final List<FlSpot> chartPointsAll,
      required this.allDaysDuration,
      required this.maxWordLength})
      : _chartPointsAll = chartPointsAll;

  final List<FlSpot> _chartPointsAll;
  @override
  List<FlSpot> get chartPointsAll {
    if (_chartPointsAll is EqualUnmodifiableListView) return _chartPointsAll;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chartPointsAll);
  }

  @override
  final double allDaysDuration;
  @override
  final double maxWordLength;

  @override
  String toString() {
    return 'DateChartViewModel(chartPointsAll: $chartPointsAll, allDaysDuration: $allDaysDuration, maxWordLength: $maxWordLength)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DateChartViewModel &&
            const DeepCollectionEquality()
                .equals(other._chartPointsAll, _chartPointsAll) &&
            (identical(other.allDaysDuration, allDaysDuration) ||
                other.allDaysDuration == allDaysDuration) &&
            (identical(other.maxWordLength, maxWordLength) ||
                other.maxWordLength == maxWordLength));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_chartPointsAll),
      allDaysDuration,
      maxWordLength);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DateChartViewModelCopyWith<_$_DateChartViewModel> get copyWith =>
      __$$_DateChartViewModelCopyWithImpl<_$_DateChartViewModel>(
          this, _$identity);
}

abstract class _DateChartViewModel implements DateChartViewModel {
  const factory _DateChartViewModel(
      {required final List<FlSpot> chartPointsAll,
      required final double allDaysDuration,
      required final double maxWordLength}) = _$_DateChartViewModel;

  @override
  List<FlSpot> get chartPointsAll;
  @override
  double get allDaysDuration;
  @override
  double get maxWordLength;
  @override
  @JsonKey(ignore: true)
  _$$_DateChartViewModelCopyWith<_$_DateChartViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}
