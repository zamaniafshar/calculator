import 'package:calculator/calculator/calculator.dart';
import 'package:calculator/calculator/expressions.dart';
import 'package:calculator/calculator/strategies.dart';
import 'package:calculator/logic/calculator_state.dart';
import 'package:flutter/cupertino.dart';

class CalculatorNotifier extends ValueNotifier<CalculatorNotifierState> {
  CalculatorNotifier() : super(CalculatorNotifierState(expression: ''));

  final _calculator = Calculator();

  void addNumber(String symbol, NumberExpression num) {
    _calculator.number(num);
    _notifyChange(symbol);
  }

  void addOperator(String symbol, OperatorStrategy op) {
    _calculator.operatorSym(op);
    _notifyChange(symbol);
  }

  void addFunction(String symbol, FunctionStrategy fn) {
    _calculator.functionName(fn);
    _notifyChange(symbol);
  }

  void _notifyChange(String newSymbol) {
    value = value.copyWith(
      expression: value.expression + newSymbol,
    );

    try {
      final result = _calculator.calculate();
      value = value.copyWith(
        result: result,
      );
    } catch (e) {
      value = value.copyWith(
        error: 'Invalid expression',
      );
    }
  }
}
