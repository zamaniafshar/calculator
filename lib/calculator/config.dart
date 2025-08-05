import 'package:calculator/calculator/functions.dart';
import 'package:calculator/calculator/operators.dart';
import 'package:calculator/calculator/strategies.dart';

// Holds the configuration for a calculator, including its supported operators and functions.
class CalculatorConfig {
  final Map<String, OperatorStrategy> operators;
  final Map<String, FunctionStrategy> functions;
  CalculatorConfig(this.operators, this.functions);

  // Creates a configuration for a standard mathematical calculator.
  factory CalculatorConfig.math() => CalculatorConfig(
        {
          '+': Add(),
          '-': Subtract(),
          '*': Multiply(),
          '/': Divide(),
          '^': Power(),
        },
        {
          'sin': SinFn(),
          '√': SqrtFn(),
        },
      );

  // Creates a configuration for a programmer's calculator with bitwise operations.
  factory CalculatorConfig.programmer() => CalculatorConfig({
        '&': BitwiseAnd(),
        '|': BitwiseOr(),
        '<<': ShiftLeft(),
        '+': Add(),
        '-': Subtract(),
        '*': Multiply(),
        '/': Divide(),
      }, {});

  // Creates a configuration for a scientific calculator with additional functions.
  factory CalculatorConfig.scientific() =>
      CalculatorConfig(CalculatorConfig.math().operators, {
        'sin': SinFn(),
        'log': LogFn(),
        '√': SqrtFn(),
      });
}
