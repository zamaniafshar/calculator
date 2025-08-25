import 'package:freezed_annotation/freezed_annotation.dart';

part 'calculator_state.freezed.dart';

@freezed
class CalculatorNotifierState with _$CalculatorNotifierState {
  const factory CalculatorNotifierState({
    double? result,
    @Default('') String expression,
    String? error,
  }) = _CalculatorNotifierState;
}
