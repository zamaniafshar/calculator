import 'package:calculator/calculator/exoression_tokenizer.dart';
import 'package:calculator/calculator/expression_factory.dart';
import 'package:calculator/calculator/expressions.dart';
import 'package:calculator/calculator/strategies.dart';

class Calculator {
  List _expressions = [];

  double calculate(String expression) {
    try {
      _expressions.clear();
      final tokens = ExpressionTokenizer.tokenize(expression);
      _expressions = tokens.map(ExpressionFactory.create).toList();

      return _calculate();
    } catch (e) {
      throw Exception('Invalid expression');
    }
  }

  double _calculate() {
    while (_expressions.length != 1) {
      final highestPriority = _findHighestPriority();
      final index = _expressions.indexOf(highestPriority);
      if (highestPriority is DyadicOperator) {
        final right = _expressions[index + 1];
        final left = _expressions[index - 1];
        final newExp = highestPriority.create(left, right);
        _expressions.replaceRange(index - 1, index + 2, [newExp]);
      } else if (highestPriority is FunctionOperator) {
        final arg = _expressions[index + 1];
        final newExp = highestPriority.create(arg);
        _expressions.replaceRange(index, index + 2, [newExp]);
      }
    }

    return _expressions.first.evaluate();
  }

  Operator _findHighestPriority() {
    return _expressions.whereType<Operator>().reduce(
      (a, b) {
        if (a.priority > b.priority) {
          return a;
        }

        if (a.priority == b.priority && a.isLeftAssociative) {
          return a;
        }

        return b;
      },
    );
  }
}
