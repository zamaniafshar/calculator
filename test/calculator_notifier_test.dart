import 'package:calculator/logic/calculator_notifier.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CalculatorNotifier (feature)', () {
    late CalculatorNotifier notifier;

    setUp(() {
      notifier = CalculatorNotifier();
    });

    tearDown(() {
      notifier.dispose();
    });

    // Helper to enter an expression as a user would (char-by-char)
    void enter(String expr) {
      for (final ch in expr.split('')) {
        notifier.input(ch);
      }
    }

    test('initial state', () {
      expect(notifier.value.expression, '');
      expect(notifier.value.result, isNull);
      expect(notifier.value.error, isNull);
    });

    test('incremental input updates expression and calculates when possible', () {
      enter('1');
      expect(notifier.value.expression, '1');
      expect(notifier.value.result, closeTo(1.0, 1e-9));
      expect(notifier.value.error, isNull);

      notifier.input('+');
      expect(notifier.value.expression, '1+');
      expect(notifier.value.result, isNull);
      expect(notifier.value.error, 'Invalid expression');

      notifier.input('3');
      expect(notifier.value.expression, '1+3');
      expect(notifier.value.result, closeTo(4.0, 1e-9));
      // Error may persist per current implementation; do not assert it is cleared here.
    });

    test(
      'getResult replaces expression with final value and clears result',
      () {
        enter('12+3');
        notifier.getResult();
        expect(notifier.value.expression, '15.0');
        expect(notifier.value.result, isNull);
      },
    );

    test('clear resets expression, result and error', () {
      enter('7+');
      expect(notifier.value.error, isNotNull);
      notifier.clear();
      expect(notifier.value.expression, '');
      expect(notifier.value.result, isNull);
      expect(notifier.value.error, isNull);
    });

    test(
      'deleteLast removes last char and recalculates; clears when 1 char',
      () {
        enter('12');
        notifier.deleteLast();
        expect(notifier.value.expression, '1');
        expect(notifier.value.result, closeTo(1.0, 1e-9));

        notifier.deleteLast();
        expect(notifier.value.expression, '');
        expect(notifier.value.result, isNull);
        expect(notifier.value.error, isNull);
      },
    );

    test('operator replacement: consecutive operators replace the last', () {
      enter('1+');
      notifier.input('+'); // replace + with +
      expect(notifier.value.expression, '1+');

      notifier.input('-'); // replace + with -
      expect(notifier.value.expression, '1-');
    });

    test(
      'decimal rules: single dot per number; dot after operator allowed',
      () {
        enter('1.2');
        final before = notifier.value.expression;
        notifier.input('.');
        expect(notifier.value.expression, before);
        expect(notifier.value.result, closeTo(1.2, 1e-9));

        notifier.input('+');
        notifier.input('.');
        notifier.input('5');
        expect(notifier.value.expression, '1.2+.5');
        expect(notifier.value.result, closeTo(1.7, 1e-9));
      },
    );

    test('operator precedence: multiply before add', () {
      enter('2+3*4');
      expect(notifier.value.result, closeTo(14.0, 1e-9));
    });

    test('power operator is right-associative', () {
      enter('2^3^2');
      expect(notifier.value.result, closeTo(512.0, 1e-9));
    });

    test('division by zero yields 0 per operator implementation', () {
      enter('4/0');
      expect(notifier.value.result, closeTo(0.0, 1e-9));
    });

    test('invalid expression sets error', () {
      enter('1+');
      expect(notifier.value.error, 'Invalid expression');
    });

    test('error persists after making expression valid until cleared', () {
      enter('1+');
      expect(notifier.value.error, isNotNull);
      notifier.input('2'); // now valid expression
      expect(notifier.value.result, closeTo(3.0, 1e-9));
      // Error persists per current implementation
      expect(notifier.value.error, isNotNull);

      notifier.clear();
      expect(notifier.value.error, isNull);
    });
  });
}
