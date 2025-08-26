import 'package:calculator/calculator/expressions.dart';

abstract interface class Operator {
  int get priority;
  bool get isLeftAssociative;
}

// Defines the interface for a binary operator in a mathematical expression.

abstract base class DyadicOperator implements Operator {
  // The precedence of the operator, used to determine the order of operations.
  // Whether the operator is left-associative.
  // Creates an expression node for this operator.
  @override
  bool get isLeftAssociative => true;

  Expression create(Expression left, Expression right) =>
      DyadicExpression(left, this, right);

  double apply(double left, double right);
}

// Defines the interface for a function in a mathematical expression.
abstract base class FunctionOperator implements Operator {
  // Creates an expression node for this function.
  Expression create(Expression argument);

  @override
  bool get isLeftAssociative => false;

  // Applies the function to the given value.
  double apply(double value);
}
