import 'package:calculator/calculator/operators.dart';
import 'package:calculator/calculator/strategies.dart';

// Represents a component in a mathematical expression.
// This is part of a composite pattern where expressions can be simple numbers
// or complex binary/function expressions.
abstract class Expression {
  // Evaluates the expression and returns the result.
  double evaluate();
}

// A leaf node in the expression composite, representing a numeric value.
class NumberExpression implements Expression {
  final double value;
  NumberExpression(this.value);

  @override
  double evaluate() => value;
}

// A composite node representing a binary operation (e.g., addition, subtraction).
class BinaryExpression implements Expression {
  final Expression left;
  final Expression right;
  final OperatorStrategy op;
  BinaryExpression(this.left, this.op, this.right);

  @override
  double evaluate() {
    // Handle programmer-specific operators that work with integers.
    if (op is ProgrammerOperator) {
      return (op as ProgrammerOperator)
          .applyInt(left.evaluate().toInt(), right.evaluate().toInt())
          .toDouble();
    } else {
      // Handle standard mathematical operators.
      return (op as MathOperator).apply(left.evaluate(), right.evaluate());
    }
  }
}

// A composite node representing a function call (e.g., sin, log).
class FunctionExpression implements Expression {
  final Expression argument;
  final FunctionStrategy fn;
  FunctionExpression(this.fn, this.argument);

  @override
  double evaluate() => fn.apply(argument.evaluate());
}
