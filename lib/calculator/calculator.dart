import 'package:calculator/calculator/expressions.dart';
import 'package:calculator/calculator/strategies.dart';

// Builds an expression from a sequence of numbers and operators using the shunting-yard algorithm.
class Calculator {
  final List<Expression> _values = [];
  final List<dynamic> _stack = [];

  double calculate() {
    // Process all remaining operators in the stack
    while (_stack.isNotEmpty) {
      if (_stack.last == '(') throw StateError('Unmatched (');
      _pop();
    }

    if (_values.length != 1) throw StateError('Invalid expression');
    final expression = _values.single;
    return expression.evaluate();
  }

  void number(NumberExpression v) {
    _values.add(v);
  }

  void operatorSym(OperatorStrategy op) {
    _shuntOperator(op);
  }

  void functionName(FunctionStrategy fn) {
    _stack.add(fn);
  }

  // Handles a left parenthesis.
  void leftParen() {
    _stack.add('(');
  }

  // Handles a right parenthesis.
  void rightParen() {
    while (_stack.isNotEmpty && _stack.last != '(') {
      _pop();
    }
    // Check if we found a matching left parenthesis
    if (_stack.isEmpty) {
      throw StateError('Unmatched )');
    }
    _stack.removeLast(); // Pop the '('
    if (_stack.isNotEmpty && _stack.last is FunctionStrategy) _pop();
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
