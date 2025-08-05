final class CalculatorNotifierState {
  CalculatorNotifierState({this.result, this.error, this.expression = ''});

  final double? result;
  final String expression;
  final String? error;

  CalculatorNotifierState copyWith({
    double? result,
    String? expression,
    String? error,
  }) {
    return CalculatorNotifierState(
      result: result ?? this.result,
      expression: expression ?? this.expression,
      error: error ?? this.error,
    );
  }
}
