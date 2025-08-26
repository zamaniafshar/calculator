import 'package:calculator/calculator/calculator.dart';
import 'package:calculator/bloc/calculator_state.dart';
import 'package:calculator/bloc/expression_validator.dart';
import 'package:flutter/cupertino.dart';

class CalculatorNotifier extends ValueNotifier<CalculatorNotifierState> {
  CalculatorNotifier() : super(CalculatorNotifierState(expression: ''));

  final _calculator = Calculator();
  final _validator = ExpressionValidator();

  void input(String symbol) {
    final updatedExpression = _validator.getUpdatedExpression(
      value.expression,
      symbol,
    );

    value = value.copyWith(
      expression: updatedExpression,
    );

    _calculate();
  }

  void clear() {
    value = value.copyWith(
      expression: '',
      result: null,
      error: null,
    );
  }

  void deleteLast() {
    if (value.expression.isEmpty || value.expression.length == 1) {
      clear();
      return;
    }

    value = value.copyWith(
      expression: value.expression.substring(0, value.expression.length - 1),
    );
    _calculate();
  }

  void getResult() {
    _calculate();
    value = value.copyWith(
      result: null,
      expression: value.result?.toString() ?? '',
    );
  }

  void _calculate() {
    try {
      final result = _calculator.calculate(value.expression);
      value = value.copyWith(
        result: result,
      );
    } catch (e) {
      value = value.copyWith(
        result: null,
        error: 'Invalid expression',
      );
    }
  }
}
