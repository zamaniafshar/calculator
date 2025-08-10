import 'package:calculator/calculator/calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void _testCalculator(String expression, double expectedResult) {
  test('expression: $expression should return $expectedResult', () {
    final result = calculator.calculate(expression);
    expect(result, expectedResult);
  });
}

late Calculator calculator;

void main() {
  setUp(() {
    calculator = Calculator();
  });
  group('Calculator  Basic Operations', () {
    _testCalculator('1+1', 2);
    _testCalculator('5-3', 2);
    _testCalculator('4*3', 12);
    _testCalculator('8/2', 4);
    _testCalculator('2^3', 8);
  });

  group('Calculator  Decimal Operations', () {
    _testCalculator('2.5+3.7', 6.2);
    _testCalculator('5.5-2.2', 3.3);
    _testCalculator('2.5*4', 10);
    _testCalculator('7.5/2.5', 3);
    _testCalculator('2.5^2', 6.25);
  });

  group('Calculator  Operator Precedence', () {
    _testCalculator('2+3*4', 14); // 2 + (3*4) = 14
    _testCalculator('10-3*2', 4); // 10 - (3*2) = 4
    _testCalculator('8/2+3', 7); // (8/2) + 3 = 7
    _testCalculator('2+8/2', 6); // 2 + (8/2) = 6
    _testCalculator('2*3^2', 18); // 2 * (3^2) = 18
  });

  group('Calculator  Complex Expressions', () {
    _testCalculator('2+3-4', 1);
    _testCalculator('10/2+3*4', 17); // 5 + 12 = 17
    _testCalculator('2+3*4-5', 9); // 2 + 12 - 5 = 9
    _testCalculator('2^3*4-5', 27); // 8 * 4 - 5 = 27
    _testCalculator('12/3+5*2', 14); // 4 + 10 = 14
  });

  group('Calculator  Edge Cases', () {
    _testCalculator('0+0', 0);
    _testCalculator('1-1', 0);
    _testCalculator('0*5', 0);
    _testCalculator('5/1', 5);
    _testCalculator('1^5', 1);
    _testCalculator('5/0', 0);
  });

  group('Calculator  Whitespace Handling', () {
    _testCalculator(' 2 + 3 ', 5);
    _testCalculator('10   -   5', 5);
    _testCalculator('  3  *  4  ', 12);
    _testCalculator('  8  /  2  ', 4);
  });

  test('should throw exception for invalid expression', () {
    expect(() => calculator.calculate('2++3'), throwsA(isException));
  });
}
