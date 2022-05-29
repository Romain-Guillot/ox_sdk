// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'distance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Distance {
  double get value => throw _privateConstructorUsedError;
  DistanceUnit get unit => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DistanceCopyWith<Distance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DistanceCopyWith<$Res> {
  factory $DistanceCopyWith(Distance value, $Res Function(Distance) then) =
      _$DistanceCopyWithImpl<$Res>;
  $Res call({double value, DistanceUnit unit});
}

/// @nodoc
class _$DistanceCopyWithImpl<$Res> implements $DistanceCopyWith<$Res> {
  _$DistanceCopyWithImpl(this._value, this._then);

  final Distance _value;
  // ignore: unused_field
  final $Res Function(Distance) _then;

  @override
  $Res call({
    Object? value = freezed,
    Object? unit = freezed,
  }) {
    return _then(_value.copyWith(
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      unit: unit == freezed
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as DistanceUnit,
    ));
  }
}

/// @nodoc
abstract class _$DistanceCopyWith<$Res> implements $DistanceCopyWith<$Res> {
  factory _$DistanceCopyWith(_Distance value, $Res Function(_Distance) then) =
      __$DistanceCopyWithImpl<$Res>;
  @override
  $Res call({double value, DistanceUnit unit});
}

/// @nodoc
class __$DistanceCopyWithImpl<$Res> extends _$DistanceCopyWithImpl<$Res>
    implements _$DistanceCopyWith<$Res> {
  __$DistanceCopyWithImpl(_Distance _value, $Res Function(_Distance) _then)
      : super(_value, (v) => _then(v as _Distance));

  @override
  _Distance get _value => super._value as _Distance;

  @override
  $Res call({
    Object? value = freezed,
    Object? unit = freezed,
  }) {
    return _then(_Distance(
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      unit: unit == freezed
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as DistanceUnit,
    ));
  }
}

/// @nodoc

class _$_Distance extends _Distance {
  _$_Distance({required this.value, required this.unit}) : super._();

  @override
  final double value;
  @override
  final DistanceUnit unit;

  @override
  String toString() {
    return 'Distance(value: $value, unit: $unit)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Distance &&
            const DeepCollectionEquality().equals(other.value, value) &&
            const DeepCollectionEquality().equals(other.unit, unit));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(value),
      const DeepCollectionEquality().hash(unit));

  @JsonKey(ignore: true)
  @override
  _$DistanceCopyWith<_Distance> get copyWith =>
      __$DistanceCopyWithImpl<_Distance>(this, _$identity);
}

abstract class _Distance extends Distance {
  factory _Distance(
      {required final double value,
      required final DistanceUnit unit}) = _$_Distance;
  _Distance._() : super._();

  @override
  double get value => throw _privateConstructorUsedError;
  @override
  DistanceUnit get unit => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$DistanceCopyWith<_Distance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DistanceFieldValue {
  double? get value => throw _privateConstructorUsedError;
  DistanceUnit? get unit => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DistanceFieldValueCopyWith<DistanceFieldValue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DistanceFieldValueCopyWith<$Res> {
  factory $DistanceFieldValueCopyWith(
          DistanceFieldValue value, $Res Function(DistanceFieldValue) then) =
      _$DistanceFieldValueCopyWithImpl<$Res>;
  $Res call({double? value, DistanceUnit? unit});
}

/// @nodoc
class _$DistanceFieldValueCopyWithImpl<$Res>
    implements $DistanceFieldValueCopyWith<$Res> {
  _$DistanceFieldValueCopyWithImpl(this._value, this._then);

  final DistanceFieldValue _value;
  // ignore: unused_field
  final $Res Function(DistanceFieldValue) _then;

  @override
  $Res call({
    Object? value = freezed,
    Object? unit = freezed,
  }) {
    return _then(_value.copyWith(
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double?,
      unit: unit == freezed
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as DistanceUnit?,
    ));
  }
}

/// @nodoc
abstract class _$DistanceFieldValueCopyWith<$Res>
    implements $DistanceFieldValueCopyWith<$Res> {
  factory _$DistanceFieldValueCopyWith(
          _DistanceFieldValue value, $Res Function(_DistanceFieldValue) then) =
      __$DistanceFieldValueCopyWithImpl<$Res>;
  @override
  $Res call({double? value, DistanceUnit? unit});
}

/// @nodoc
class __$DistanceFieldValueCopyWithImpl<$Res>
    extends _$DistanceFieldValueCopyWithImpl<$Res>
    implements _$DistanceFieldValueCopyWith<$Res> {
  __$DistanceFieldValueCopyWithImpl(
      _DistanceFieldValue _value, $Res Function(_DistanceFieldValue) _then)
      : super(_value, (v) => _then(v as _DistanceFieldValue));

  @override
  _DistanceFieldValue get _value => super._value as _DistanceFieldValue;

  @override
  $Res call({
    Object? value = freezed,
    Object? unit = freezed,
  }) {
    return _then(_DistanceFieldValue(
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double?,
      unit: unit == freezed
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as DistanceUnit?,
    ));
  }
}

/// @nodoc

class _$_DistanceFieldValue extends _DistanceFieldValue {
  _$_DistanceFieldValue({this.value, this.unit}) : super._();

  @override
  final double? value;
  @override
  final DistanceUnit? unit;

  @override
  String toString() {
    return 'DistanceFieldValue(value: $value, unit: $unit)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DistanceFieldValue &&
            const DeepCollectionEquality().equals(other.value, value) &&
            const DeepCollectionEquality().equals(other.unit, unit));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(value),
      const DeepCollectionEquality().hash(unit));

  @JsonKey(ignore: true)
  @override
  _$DistanceFieldValueCopyWith<_DistanceFieldValue> get copyWith =>
      __$DistanceFieldValueCopyWithImpl<_DistanceFieldValue>(this, _$identity);
}

abstract class _DistanceFieldValue extends DistanceFieldValue {
  factory _DistanceFieldValue({final double? value, final DistanceUnit? unit}) =
      _$_DistanceFieldValue;
  _DistanceFieldValue._() : super._();

  @override
  double? get value => throw _privateConstructorUsedError;
  @override
  DistanceUnit? get unit => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$DistanceFieldValueCopyWith<_DistanceFieldValue> get copyWith =>
      throw _privateConstructorUsedError;
}
