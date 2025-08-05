import 'dart:math' as math;

import 'package:calculator/calculator/expressions.dart';
import 'package:calculator/calculator/strategies.dart';

// Defines the base for mathematical functions.
abstract class GenericFunction implements FunctionStrategy {
  // Applies the function to a single value.
  @override
  double apply(double x);

  @override
  Expression create(Expression arg) => FunctionExpression(this, arg);
}

// Represents the sine function (expects input in degrees).
class SinFn extends GenericFunction {
  @override
  String get name => 'sin';
  @override
  double apply(double value) => math.sin(value * math.pi / 180);
  @override
  Expression create(Expression argument) => FunctionExpression(this, argument);
}

// Represents the natural logarithm function.
class LogFn extends GenericFunction {
  @override
  String get name => 'log';
  @override
  double apply(double value) => math.log(value);
  @override
  Expression create(Expression argument) => FunctionExpression(this, argument);
}

// Represents the square root function.
class SqrtFn extends GenericFunction {
  @override
  String get name => 'sqrt';
  @override
  double apply(double value) => math.sqrt(value);
  @override
  Expression create(Expression argument) => FunctionExpression(this, argument);
}
