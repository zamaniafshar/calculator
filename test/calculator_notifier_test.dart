import 'package:calculator/calculator_notifier.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Calculator Notifier', () {
    late CalculatorNotifier notifier;

    setUp(() {
      notifier = CalculatorNotifier();
    });

    group('add', () {
      test('1+1', () {
        notifier
          ..addNumber('1')
          ..add()
          ..addNumber('1');
        final result = notifier.value.result;
        final expression = notifier.value.expression;

        expect(result, equals(2));
        expect(expression, '1+1');
      });

      test('1+1+1', () {
        notifier
          ..addNumber('1')
          ..add()
          ..addNumber('1')
          ..add()
          ..addNumber('1');
        final result = notifier.value.result;
        final expression = notifier.value.expression;

        expect(result, equals(3));
        expect(expression, '1+1+1');
      });
    });

    group('minus', () {
      test('2-1', () {
        notifier
          ..addNumber('2')
          ..minus()
          ..addNumber('1');
        final result = notifier.value.result;
        final expression = notifier.value.expression;

        expect(result, equals(1));
        expect(expression, '2-1');
      });
    });

    group('multiply', () {
      test('2*3', () {
        notifier
          ..addNumber('2')
          ..multiply()
          ..addNumber('3');
        final result = notifier.value.result;
        final expression = notifier.value.expression;

        expect(result, equals(6));
        expect(expression, '2*3');
      });
    });

    group('divider', () {
      test('6/2', () {
        notifier
          ..addNumber('6')
          ..divider()
          ..addNumber('2');
        final result = notifier.value.result;
        final expression = notifier.value.expression;

        expect(result, equals(3));
        expect(expression, '6/2');
      });
    });

    group('mixed operations', () {
      test('1+2*3', () {
        notifier
          ..addNumber('1')
          ..add()
          ..addNumber('2')
          ..multiply()
          ..addNumber('3');
        final result = notifier.value.result;
        final expression = notifier.value.expression;

        expect(result, equals(7));
        expect(expression, '1+2*3');
      });

      test('6/2-1', () {
        notifier
          ..addNumber('6')
          ..divider()
          ..addNumber('2')
          ..minus()
          ..addNumber('1');
        final result = notifier.value.result;
        final expression = notifier.value.expression;

        expect(result, equals(2));
        expect(expression, '6/2-1');
      });
    });
  });
}
