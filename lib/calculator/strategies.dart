import 'package:calculator/calculator/expressions.dart';

// Defines the interface for a binary operator in a mathematical expression.

abstract class OperatorStrategy {
  // The symbol representing the operator (e.g., '+', '-', '*', '/').
  String get symbol;
  // The precedence of the operator, used to determine the order of operations.
  int get precedence;
  // Whether the operator is left-associative.
  bool get isLeftAssociative;
  // Creates an expression node for this operator.
  Expression create(Expression left, Expression right);
}

// Defines the interface for a function in a mathematical expression.
abstract class FunctionStrategy {
  // The name of the function (e.g., 'sin', 'log').
  String get name;
  // Creates an expression node for this function.
  Expression create(Expression argument);
  // Applies the function to the given value.
  double apply(double value);
}
