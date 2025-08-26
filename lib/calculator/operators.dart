import 'dart:math' as math;

import 'package:calculator/calculator/priority_list.dart';
import 'package:calculator/calculator/operators_base.dart';

final class Add extends DyadicOperator {
  @override
  int get priority => PriorityList.minusAdd;

  @override
  double apply(double a, double b) => a + b;
}

final class Subtract extends DyadicOperator {
  @override
  int get priority => PriorityList.minusAdd;

  @override
  double apply(double a, double b) => a - b;
}

final class Multiply extends DyadicOperator {
  @override
  int get priority => PriorityList.multiplyDivide;

  @override
  double apply(double a, double b) => a * b;
}

final class Divide extends DyadicOperator {
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

final class Power extends DyadicOperator {
  @override
  int get priority => PriorityList.power;
  @override
  bool get isLeftAssociative => false;
  @override
  double apply(double a, double b) => math.pow(a, b).toDouble();
}
