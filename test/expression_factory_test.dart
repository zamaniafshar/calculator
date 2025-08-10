import 'package:calculator/calculator/expression_factory.dart';
import 'package:calculator/calculator/expressions.dart';
import 'package:calculator/calculator/operators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExpressionFactory', () {
    group('number creation', () {
      _testNumberCreation('42', 42.0);
      _testNumberCreation('3.14', 3.14);
      _testNumberCreation('-5', -5.0);
      _testNumberCreation('-2.5', -2.5);
      _testNumberCreation('0', 0.0);
      _testNumberCreation('0.0', 0.0);
      _testNumberCreation('999999.999', 999999.999);
    });

    group('operator creation', () {
      _testOperatorCreation<Add>('+');
      _testOperatorCreation<Subtract>('-');
      _testOperatorCreation<Multiply>('*');
      _testOperatorCreation<Divide>('/');
      _testOperatorCreation<Power>('^');
    });

    group('error handling', () {
      _testException('invalid', 'invalid token should throw exception');
      _testException('', 'empty string should throw exception');
      _testException('null', 'null-like string should throw exception');
      _testException('abc', 'alphabetic string should throw exception');
      _testException('@', 'special characters should throw exception');
    });

    group('error handling', () {
      _testException(
        'invalid',
        'invalid operator should throw exception',
      );
      _testException('5-', 'invalid number string should throw exception');
      _testException('', 'empty string should throw exception');
      _testException('(', 'parenthesis should throw exception');
      _testException('%', 'percentage symbol should throw exception');
    });
  });
}

void _testOperatorCreation<T>(String operator) {
  return test('"$operator" should create $T operator', () {
    final result = ExpressionFactory.create(operator);
    expect(result, isA<T>());
  });
}

void _testNumberCreation(String token, double expectedValue) {
  test('"$token" should create NumberExpression with value $expectedValue', () {
    final result = ExpressionFactory.create(token);
    expect(result, isA<NumberExpression>());
    expect(result.evaluate(), equals(expectedValue));
  });
}

void _testException(String token, String testDescription) {
  test(testDescription, () {
    expect(() => ExpressionFactory.create(token), throwsException);
  });
}
