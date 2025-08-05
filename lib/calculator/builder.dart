import 'package:calculator/calculator/config.dart';
import 'package:calculator/calculator/expressions.dart';
import 'package:calculator/calculator/strategies.dart';

// Builds an expression from a sequence of numbers and operators using the shunting-yard algorithm.
class CalculatorBuilder {
  CalculatorBuilder(CalculatorConfig config)
      : _ops = config.operators,
        _fns = config.functions;

  final Map<String, OperatorStrategy> _ops;
  final Map<String, FunctionStrategy> _fns;
  final List<Expression> _values = [];
  final List<dynamic> _stack = [];

  Expression build(String expression) {
    clear();
    final tokens = _tokenize(expression);
    for (final token in tokens) {
      if (token is double) {
        number(token);
      } else if (_ops.containsKey(token)) {
        operatorSym(token);
      } else if (_fns.containsKey(token)) {
        functionName(token);
      } else if (token == '(') {
        leftParen();
      } else if (token == ')') {
        rightParen();
      } else {
        throw ArgumentError('Unknown token: $token');
      }
    }

    while (_stack.isNotEmpty) {
      if (_stack.last == '(') throw StateError('Unmatched (');
      _pop();
    }

    if (_values.length != 1) throw StateError('Invalid expression');
    return _values.single;
  }

  List<dynamic> _tokenize(String expression) {
    final pattern = RegExp(r'(\d*\.?\d+)|([+\-*\/&|<>^])|([a-zA-Z_][a-zA-Z0-9_]*)|([()])');
    final matches = pattern.allMatches(expression);
    final tokens = <dynamic>[];
    for (final match in matches) {
      final value = match.group(0)!;
      if (match.group(1) != null) {
        tokens.add(double.parse(value));
      } else {
        tokens.add(value);
      }
    }
    return tokens;
  }


  // Adds a number to the expression.
  CalculatorBuilder number(double v) {
    _values.add(NumberExpression(v));
    return this;
  }

  // Adds an operator to the expression.
  CalculatorBuilder operatorSym(String s) {
    final op = _ops[s] ?? (throw ArgumentError('Unknown operator: $s'));
    _shuntOperator(op);
    return this;
  }

  // Adds a function to the expression.
  CalculatorBuilder functionName(String n) {
    final fn = _fns[n] ?? (throw ArgumentError('Unknown function: $n'));
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
      final r = _values.removeLast();
      final l = _values.removeLast();
      _values.add(top.create(l, r));
    } else if (top is FunctionStrategy) {
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
