import 'dart:math' as math;

import 'package:calculator/calculator/expressions.dart';
import 'package:calculator/calculator/priority_list.dart';
import 'package:calculator/calculator/strategies.dart';

// Represents the sine function (expects input in degrees).
class SinFn extends FunctionOperator {
  @override
  double apply(double value) => math.sin(value * math.pi / 180);
  @override
  Expression create(Expression argument) => FunctionExpression(this, argument);
  @override
  int get priority => PriorityList.functions;
}

// Represents the natural logarithm function.
class LogFn extends FunctionOperator {
  @override
  double apply(double value) => math.log(value);
  @override
  Expression create(Expression argument) => FunctionExpression(this, argument);
  @override
  int get priority => PriorityList.functions;
}

// Represents the square root function.
class SqrtFn extends FunctionOperator {
  @override
  double apply(double value) => math.sqrt(value);
  @override
  Expression create(Expression argument) => FunctionExpression(this, argument);
  @override
  int get priority => PriorityList.functions;
}
