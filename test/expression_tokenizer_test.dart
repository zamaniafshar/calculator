import 'package:calculator/calculator/exoression_tokenizer.dart';
import 'package:flutter_test/flutter_test.dart';

void _testTokenization(String expression, List<String> expectedTokens) {
  test('"$expression" should tokenize to $expectedTokens', () {
    final result = ExpressionTokenizer.tokenize(expression);
    expect(result, equals(expectedTokens));
  });
}

void main() {
  group('ExpressionTokenizer', () {
    group('empty and whitespace handling', () {
      test('should return empty list for empty string', () {
        final result = ExpressionTokenizer.tokenize('');
        expect(result, isEmpty);
      });

      test('should return empty list for string with only whitespace', () {
        final result = ExpressionTokenizer.tokenize('   \n\t  ');
        expect(result, isEmpty);
      });
    });

    group('basic operations', () {
      _testTokenization('2+3', ['2', '+', '3']);
      _testTokenization('5-3', ['5', '-', '3']);
      _testTokenization('4*7', ['4', '*', '7']);
      _testTokenization('8/2', ['8', '/', '2']);
      _testTokenization('2^3', ['2', '^', '3']);
    });

    group('decimal numbers', () {
      _testTokenization('3.14+2.5', ['3.14', '+', '2.5']);
      _testTokenization('5.5-2.2', ['5.5', '-', '2.2']);
      _testTokenization('2.5*4', ['2.5', '*', '4']);
      _testTokenization('7.5/2.5', ['7.5', '/', '2.5']);
      _testTokenization('2.5^2', ['2.5', '^', '2']);
    });

    // group('parentheses', () {
    //   _testTokenization('(2+3)*4', ['(', '2', '+', '3', ')', '*', '4']);
    //   _testTokenization('(-2+3)*5', ['(', '-2', '+', '3', ')', '*', '5']);
    // });

    group('complex expressions', () {
      _testTokenization(
        '2+3*4-5/2',
        ['2', '+', '3', '*', '4', '-', '5', '/', '2'],
      );
      _testTokenization('999999.999+0.001', ['999999.999', '+', '0.001']);
    });

    group('whitespace handling', () {
      _testTokenization('  2   +   3  ', ['2', '+', '3']);
    });
  });
}
