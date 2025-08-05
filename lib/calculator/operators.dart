import 'dart:math' as math;

import 'package:calculator/calculator/expressions.dart';
import 'package:calculator/calculator/strategies.dart';

// Defines the base for standard mathematical operators.
abstract class MathOperator implements OperatorStrategy {
  // Applies the operator to two values.
  double apply(double a, double b);

  @override
  Expression create(Expression l, Expression r) => BinaryExpression(l, this, r);
}

// Represents the addition operator.
class Add extends MathOperator {
  @override
  String get symbol => '+';
  @override
  int get precedence => 1;
  @override
  bool get isLeftAssociative => true;
  @override
  double apply(double a, double b) => a + b;
  @override
  Expression create(Expression left, Expression right) =>
      BinaryExpression(left, this, right);
}

// Represents the subtraction operator.
class Subtract extends MathOperator {
  @override
  String get symbol => '-';
  @override
  int get precedence => 1;
  @override
  bool get isLeftAssociative => true;
  @override
  double apply(double a, double b) => a - b;
  @override
  Expression create(Expression left, Expression right) =>
      BinaryExpression(left, this, right);
}

// Represents the multiplication operator.
class Multiply extends MathOperator {
  @override
  String get symbol => '*';
  @override
  int get precedence => 2;
  @override
  bool get isLeftAssociative => true;
  @override
  double apply(double a, double b) => a * b;
  @override
  Expression create(Expression left, Expression right) =>
      BinaryExpression(left, this, right);
}

// Represents the division operator.
class Divide extends MathOperator {
  @override
  String get symbol => '/';
  @override
  int get precedence => 2;
  @override
  bool get isLeftAssociative => true;
  @override
  double apply(double a, double b) => a / b;
  @override
  Expression create(Expression left, Expression right) =>
      BinaryExpression(left, this, right);
}

// Represents the power operator.
class Power extends MathOperator {
  @override
  String get symbol => '^';
  @override
  int get precedence => 3;
  @override
  bool get isLeftAssociative => false;
  @override
  double apply(double a, double b) => math.pow(a, b).toDouble();
  @override
  Expression create(Expression left, Expression right) =>
      BinaryExpression(left, this, right);
}

// // Defines the base for programmer-specific bitwise operators.
// abstract class ProgrammerOperator implements OperatorStrategy {
//   // Applies the bitwise operator to two integer values.
//   int applyInt(int a, int b);

//   @override
//   Expression create(Expression l, Expression r) => BinaryExpression(l, this, r);
// }

// // Represents the bitwise AND operator.
// class BitwiseAnd extends ProgrammerOperator {
//   @override
//   String get symbol => '&';
//   @override
//   int get precedence => 0;
//   @override
//   bool get isLeftAssociative => true;
//   @override
//   int applyInt(int a, int b) => a & b;
//   @override
//   Expression create(Expression left, Expression right) =>
//       BinaryExpression(left, this, right);
// }

// // Represents the bitwise OR operator.
// class BitwiseOr extends ProgrammerOperator {
//   @override
//   String get symbol => '|';
//   @override
//   int get precedence => 0;
//   @override
//   bool get isLeftAssociative => true;
//   @override
//   int applyInt(int a, int b) => a | b;
//   @override
//   Expression create(Expression left, Expression right) =>
//       BinaryExpression(left, this, right);
// }

// // Represents the bitwise left shift operator.
// class ShiftLeft extends ProgrammerOperator {
//   @override
//   String get symbol => '<<';
//   @override
//   int get precedence => 0;
//   @override
//   bool get isLeftAssociative => true;
//   @override
//   int applyInt(int a, int b) => a << b;
//   @override
//   Expression create(Expression left, Expression right) =>
//       BinaryExpression(left, this, right);
// }
