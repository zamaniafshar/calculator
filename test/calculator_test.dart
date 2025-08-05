import 'package:flutter_test/flutter_test.dart';
import 'package:calculator/calculator/calculator.dart';
import 'package:calculator/calculator/expressions.dart';
import 'package:calculator/calculator/operators.dart';
import 'package:calculator/calculator/functions.dart';

void main() {
  group('Calculator', () {
    late Calculator calculator;

    setUp(() {
      calculator = Calculator();
    });

    group('Basic Operations', () {
      test('should add two numbers', () {
        calculator.number(NumberExpression(2));
        calculator.operatorSym(Add());
        calculator.number(NumberExpression(3));
        expect(calculator.calculate(), 5);
      });

      test('should subtract two numbers', () {
        calculator.number(NumberExpression(5));
        calculator.operatorSym(Subtract());
        calculator.number(NumberExpression(3));
        expect(calculator.calculate(), 2);
      });

      test('should subtract two numbers with negative result', () {
        calculator.number(NumberExpression(5));
        calculator.operatorSym(Subtract());
        calculator.number(NumberExpression(7));
        expect(calculator.calculate(), -2);
      });

      test('should multiply two numbers', () {
        calculator.number(NumberExpression(4));
        calculator.operatorSym(Multiply());
        calculator.number(NumberExpression(3));
        expect(calculator.calculate(), 12);
      });

      test('should divide two numbers', () {
        calculator.number(NumberExpression(8));
        calculator.operatorSym(Divide());
        calculator.number(NumberExpression(2));
        expect(calculator.calculate(), 4);
      });

      test('should calculate power', () {
        calculator.number(NumberExpression(2));
        calculator.operatorSym(Power());
        calculator.number(NumberExpression(3));
        expect(calculator.calculate(), 8);
      });
    });

    group('Order of Operations', () {
      test('should respect multiplication precedence over addition', () {
        calculator.number(NumberExpression(2));
        calculator.operatorSym(Add());
        calculator.number(NumberExpression(3));
        calculator.operatorSym(Multiply());
        calculator.number(NumberExpression(4));
        expect(calculator.calculate(), 14); // 2 + (3 * 4) = 2 + 12 = 14
      });

      test('should respect power precedence over multiplication', () {
        calculator.number(NumberExpression(2));
        calculator.operatorSym(Multiply());
        calculator.number(NumberExpression(3));
        calculator.operatorSym(Power());
        calculator.number(NumberExpression(2));
        expect(calculator.calculate(), 18); // 2 * (3 ^ 2) = 2 * 9 = 18
      });

      test('should handle left associativity for addition', () {
        calculator.number(NumberExpression(10));
        calculator.operatorSym(Subtract());
        calculator.number(NumberExpression(5));
        calculator.operatorSym(Subtract());
        calculator.number(NumberExpression(3));
        expect(calculator.calculate(), 2); // (10 - 5) - 3 = 5 - 3 = 2
      });

      test('should handle right associativity for power', () {
        calculator.number(NumberExpression(2));
        calculator.operatorSym(Power());
        calculator.number(NumberExpression(3));
        calculator.operatorSym(Power());
        calculator.number(NumberExpression(2));
        expect(calculator.calculate(), 512); // 2 ^ (3 ^ 2) = 2 ^ 9 = 512
      });
    });

    group('Parentheses', () {
      test('should handle parentheses overriding precedence', () {
        calculator.number(NumberExpression(2));
        calculator.operatorSym(Add());
        calculator.leftParen();
        calculator.number(NumberExpression(3));
        calculator.operatorSym(Multiply());
        calculator.number(NumberExpression(4));
        calculator.rightParen();
        expect(calculator.calculate(), 14); // 2 + (3 * 4) = 2 + 12 = 14
      });

      test('should handle nested parentheses', () {
        calculator.number(NumberExpression(2));
        calculator.operatorSym(Multiply());
        calculator.leftParen();
        calculator.number(NumberExpression(3));
        calculator.operatorSym(Add());
        calculator.leftParen();
        calculator.number(NumberExpression(4));
        calculator.operatorSym(Subtract());
        calculator.number(NumberExpression(1));
        calculator.rightParen();
        calculator.rightParen();
        expect(
          calculator.calculate(),
          12,
        ); // 2 * (3 + (4 - 1)) = 2 * (3 + 3) = 2 * 6 = 12
      });

      test('should throw error for unmatched left parenthesis', () {
        calculator.number(NumberExpression(2));
        calculator.operatorSym(Add());
        calculator.leftParen();
        calculator.number(NumberExpression(3));
        expect(() => calculator.calculate(), throwsA(isA<StateError>()));
      });

      test('should throw error for unmatched right parenthesis', () {
        calculator.number(NumberExpression(2));
        calculator.operatorSym(Add());
        calculator.number(NumberExpression(3));
        expect(() => calculator.rightParen(), throwsA(isA<StateError>()));
      });
    });

    group('Functions', () {
      test('should calculate sine of a number', () {
        calculator.functionName(SinFn());
        calculator.leftParen();
        calculator.number(NumberExpression(90));
        calculator.rightParen();
        expect(calculator.calculate(), closeTo(1, 0.0001));
      });

      test('should calculate logarithm of a number', () {
        calculator.functionName(LogFn());
        calculator.leftParen();
        calculator.number(NumberExpression(2.718281828459045)); // e
        calculator.rightParen();
        expect(calculator.calculate(), closeTo(1, 0.0001));
      });

      test('should calculate square root of a number', () {
        calculator.functionName(SqrtFn());
        calculator.leftParen();
        calculator.number(NumberExpression(16));
        calculator.rightParen();
        expect(calculator.calculate(), 4);
      });

      test('should handle functions with operations', () {
        calculator.functionName(SqrtFn());
        calculator.leftParen();
        calculator.number(NumberExpression(16));
        calculator.rightParen();
        calculator.operatorSym(Add());
        calculator.number(NumberExpression(2));
        expect(calculator.calculate(), 6);
      });

      test('should handle operations with functions', () {
        calculator.number(NumberExpression(10));
        calculator.operatorSym(Subtract());
        calculator.functionName(SqrtFn());
        calculator.leftParen();
        calculator.number(NumberExpression(16));
        calculator.rightParen();
        expect(calculator.calculate(), 6);
      });
    });

    group('Complex Expressions', () {
      test('should handle complex expression with multiple operations', () {
        calculator.number(NumberExpression(3));
        calculator.operatorSym(Multiply());
        calculator.leftParen();
        calculator.number(NumberExpression(4));
        calculator.operatorSym(Add());
        calculator.number(NumberExpression(2));
        calculator.rightParen();
        calculator.operatorSym(Multiply());
        calculator.number(NumberExpression(5));
        expect(calculator.calculate(), 90); // 3 * (4 + 2) * 5 = 3 * 6 * 5 = 90
      });

      test('should handle expression with functions and parentheses', () {
        calculator.functionName(SinFn());
        calculator.leftParen();
        calculator.number(NumberExpression(30));
        calculator.operatorSym(Add());
        calculator.number(NumberExpression(60));
        calculator.rightParen();
        expect(
          calculator.calculate(),
          closeTo(1, 0.0001),
        ); // sin(30 + 60) = sin(90) = 1
      });
    });

    group('Error Handling', () {
      test(
        'should throw error for invalid expression with missing operator',
        () {
          calculator.number(NumberExpression(2));
          calculator.number(NumberExpression(3));
          expect(() => calculator.calculate(), throwsA(isA<StateError>()));
        },
      );

      test(
        'should throw error for invalid expression with missing operand',
        () {
          calculator.number(NumberExpression(2));
          calculator.operatorSym(Add());
          expect(() => calculator.calculate(), throwsA(isA<StateError>()));
        },
      );

      test('should throw error for division by zero', () {
        calculator.number(NumberExpression(5));
        calculator.operatorSym(Divide());
        calculator.number(NumberExpression(0));
        // Division by zero should result in infinity, not an error
        expect(calculator.calculate(), double.infinity);
      });
    });

    group('Utility Methods', () {
      test('should clear all tokens', () {
        calculator.number(NumberExpression(2));
        calculator.operatorSym(Add());
        calculator.number(NumberExpression(3));
        calculator.clear();
        calculator.number(NumberExpression(5));
        calculator.operatorSym(Add());
        calculator.number(NumberExpression(4));
        expect(calculator.calculate(), 9);
      });

      test('should delete last token', () {
        calculator.number(NumberExpression(2));
        calculator.operatorSym(Add());
        calculator.number(NumberExpression(3));
        calculator.deleteLast(); // Remove the number 3
        calculator.number(NumberExpression(4));
        expect(calculator.calculate(), 6); // 2 + 4 = 6
      });

      test('should delete last token when it is a number', () {
        calculator.number(NumberExpression(2));
        calculator.operatorSym(Add());
        calculator.number(NumberExpression(3));
        calculator.deleteLast(); // Remove the number 3
        calculator.number(NumberExpression(5));
        expect(calculator.calculate(), 7); // 2 + 5 = 7
      });
    });
  });
}
