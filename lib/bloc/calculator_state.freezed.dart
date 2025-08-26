// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calculator_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CalculatorNotifierState {
  double? get result => throw _privateConstructorUsedError;
  String get expression => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of CalculatorNotifierState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CalculatorNotifierStateCopyWith<CalculatorNotifierState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalculatorNotifierStateCopyWith<$Res> {
  factory $CalculatorNotifierStateCopyWith(
    CalculatorNotifierState value,
    $Res Function(CalculatorNotifierState) then,
  ) = _$CalculatorNotifierStateCopyWithImpl<$Res, CalculatorNotifierState>;
  @useResult
  $Res call({double? result, String expression, String? error});
}

/// @nodoc
class _$CalculatorNotifierStateCopyWithImpl<
  $Res,
  $Val extends CalculatorNotifierState
>
    implements $CalculatorNotifierStateCopyWith<$Res> {
  _$CalculatorNotifierStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CalculatorNotifierState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? result = freezed,
    Object? expression = null,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            result: freezed == result
                ? _value.result
                : result // ignore: cast_nullable_to_non_nullable
                      as double?,
            expression: null == expression
                ? _value.expression
                : expression // ignore: cast_nullable_to_non_nullable
                      as String,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CalculatorNotifierStateImplCopyWith<$Res>
    implements $CalculatorNotifierStateCopyWith<$Res> {
  factory _$$CalculatorNotifierStateImplCopyWith(
    _$CalculatorNotifierStateImpl value,
    $Res Function(_$CalculatorNotifierStateImpl) then,
  ) = __$$CalculatorNotifierStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double? result, String expression, String? error});
}

/// @nodoc
class __$$CalculatorNotifierStateImplCopyWithImpl<$Res>
    extends
        _$CalculatorNotifierStateCopyWithImpl<
          $Res,
          _$CalculatorNotifierStateImpl
        >
    implements _$$CalculatorNotifierStateImplCopyWith<$Res> {
  __$$CalculatorNotifierStateImplCopyWithImpl(
    _$CalculatorNotifierStateImpl _value,
    $Res Function(_$CalculatorNotifierStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CalculatorNotifierState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? result = freezed,
    Object? expression = null,
    Object? error = freezed,
  }) {
    return _then(
      _$CalculatorNotifierStateImpl(
        result: freezed == result
            ? _value.result
            : result // ignore: cast_nullable_to_non_nullable
                  as double?,
        expression: null == expression
            ? _value.expression
            : expression // ignore: cast_nullable_to_non_nullable
                  as String,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$CalculatorNotifierStateImpl implements _CalculatorNotifierState {
  const _$CalculatorNotifierStateImpl({
    this.result,
    this.expression = '',
    this.error,
  });

  @override
  final double? result;
  @override
  @JsonKey()
  final String expression;
  @override
  final String? error;

  @override
  String toString() {
    return 'CalculatorNotifierState(result: $result, expression: $expression, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalculatorNotifierStateImpl &&
            (identical(other.result, result) || other.result == result) &&
            (identical(other.expression, expression) ||
                other.expression == expression) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, result, expression, error);

  /// Create a copy of CalculatorNotifierState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CalculatorNotifierStateImplCopyWith<_$CalculatorNotifierStateImpl>
  get copyWith =>
      __$$CalculatorNotifierStateImplCopyWithImpl<
        _$CalculatorNotifierStateImpl
      >(this, _$identity);
}

abstract class _CalculatorNotifierState implements CalculatorNotifierState {
  const factory _CalculatorNotifierState({
    final double? result,
    final String expression,
    final String? error,
  }) = _$CalculatorNotifierStateImpl;

  @override
  double? get result;
  @override
  String get expression;
  @override
  String? get error;

  /// Create a copy of CalculatorNotifierState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CalculatorNotifierStateImplCopyWith<_$CalculatorNotifierStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}
