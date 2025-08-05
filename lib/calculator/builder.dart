import 'package:calculator/calculator/expressions.dart';
import 'package:calculator/calculator/strategies.dart';

// Builds an expression from a sequence of numbers and operators using the shunting-yard algorithm.
class CalculatorBuilder {
  CalculatorBuilder();

  final List<Expression> _values = [];
  final List<dynamic> _stack = [];

  Expression build() {
    clear();

    while (_stack.isNotEmpty) {
      if (_stack.last == '(') throw StateError('Unmatched (');
      _pop();
    }

    if (_values.length != 1) throw StateError('Invalid expression');
    return _values.single;
  }

  CalculatorBuilder number(NumberExpression v) {
    _values.add(v);
    return this;
  }

  CalculatorBuilder operatorSym(OperatorStrategy op) {
    _shuntOperator(op);
    return this;
  }

  CalculatorBuilder functionName(FunctionStrategy fn) {
    _stack.add(fn);
    return this;
  }

  // Handles a left parenthesis.
  CalculatorBuilder leftParen() {
    _stack.add('(');
    return this;
  }

  // Handles a right parenthesis.
  CalculatorBuilder rightParen() {
    while (_stack.isNotEmpty && _stack.last != '(') _pop();
    _stack.removeLast(); // Pop the '('
    if (_stack.isNotEmpty && _stack.last is FunctionStrategy) _pop();
    return this;
  }

  // Implements the shunting-yard logic for handling operators.
  void _shuntOperator(OperatorStrategy op) {
    while (_stack.isNotEmpty && _stack.last is OperatorStrategy) {
      final top = _stack.last as OperatorStrategy;
      if ((top.precedence > op.precedence) ||
          (top.precedence == op.precedence && op.isLeftAssociative)) {
        _pop();
        continue;
      }
      break;
    }
    _stack.add(op);
  }

  // Pops an operator or function from the stack and applies it to the values.
  void _pop() {
    final top = _stack.removeLast();
    if (top is OperatorStrategy) {
      if (_values.length < 2) throw StateError('Invalid expression');
      final r = _values.removeLast();
      final l = _values.removeLast();
      _values.add(top.create(l, r));
    } else if (top is FunctionStrategy) {
      if (_values.isEmpty) throw StateError('Invalid expression');
      final a = _values.removeLast();
      _values.add(top.create(a));
    }
  }

  // Deletes the last added token (number or operator/function).
  void deleteLast() {
    if (_values.isNotEmpty) {
      _values.removeLast();
    } else if (_stack.isNotEmpty) {
      _stack.removeLast();
    }
  }

  // Clears all tokens from the builder.
  void clear() {
    _values.clear();
    _stack.clear();
  }
}
