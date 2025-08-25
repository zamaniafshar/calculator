import 'package:calculator/calculator/calculator.dart';
import 'package:calculator/calculator/expressions.dart';
import 'package:calculator/calculator/strategies.dart';
import 'package:calculator/logic/calculator_state.dart';
import 'package:flutter/cupertino.dart';

class CalculatorNotifier extends ValueNotifier<CalculatorNotifierState> {
  CalculatorNotifier() : super(CalculatorNotifierState(expression: ''));

  final _calculator = Calculator();

  void input(String symbol) {
    value = value.copyWith(
      expression: value.expression + symbol,
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
