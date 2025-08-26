import 'package:calculator/calculator/expressions.dart';
import 'package:calculator/calculator/operators.dart';

/// Factory class for creating Expression instances based on tokens/symbols
class TokenFactory {
  /// Creates an Expression based on the provided token
  /// - If token is a number, creates NumberExpression
  /// - If token is an operator symbol, returns the corresponding DyadicOperator
  /// - Returns null for unrecognized tokens
  static dynamic create(String token) {
    try {
      final value = double.parse(token);
      return NumberExpression(value);
    } catch (e) {
      return _createOperator(token);
    }
  }

  static dynamic _createOperator(String token) {
    // Check if token is an operator symbol
    switch (token) {
      case '+':
        return Add();
      case '-':
        return Subtract();
      case '*':
        return Multiply();
      case '/':
        return Divide();
      case '^':
        return Power();
      default:
        return throw Exception('invalid token');
    }
  }
}
