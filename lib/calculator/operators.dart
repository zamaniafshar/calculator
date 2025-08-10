import 'dart:math' as math;

import 'package:calculator/calculator/priority_list.dart';
import 'package:calculator/calculator/strategies.dart';

// Represents the addition operator.
class Add extends DyadicOperator {
  @override
  int get priority => PriorityList.minusAdd;

  @override
  double apply(double a, double b) => a + b;
}

// Represents the subtraction operator.
class Subtract extends DyadicOperator {
  @override
  int get priority => PriorityList.minusAdd;

  @override
  double apply(double a, double b) => a - b;
}

// Represents the multiplication operator.
class Multiply extends DyadicOperator {
  @override
  int get priority => PriorityList.multiplyDivide;

  @override
  double apply(double a, double b) => a * b;
}

// Represents the division operator.
class Divide extends DyadicOperator {
  @override
  int get priority => PriorityList.multiplyDivide;

  @override
  double apply(double a, double b) {
    if (a == 0 || b == 0) {
      return 0;
    }

    return a / b;
  }
}

// Represents the power operator.
class Power extends DyadicOperator {
  @override
  int get priority => PriorityList.power;
  @override
  bool get isLeftAssociative => false;
  @override
  double apply(double a, double b) => math.pow(a, b).toDouble();
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
