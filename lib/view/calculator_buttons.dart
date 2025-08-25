import 'package:calculator/logic/calculator_notifier.dart';
import 'package:calculator/view/math_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class CalculatorButtons extends StatelessWidget {
  const CalculatorButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final buttonRows = [
      [
        MathButton.function(
          'C',
          onPressed: () => Provider.of<CalculatorNotifier>(
            context,
            listen: false,
          ).clear(),
        ),
        MathButton.function('%'),
        MathButton.function('^'),
        MathButton.operator('/'),
      ],
      [
        MathButton.number('7'),
        MathButton.number('8'),
        MathButton.number('9'),
        MathButton.operator('*'),
      ],
      [
        MathButton.number('4'),
        MathButton.number('5'),
        MathButton.number('6'),
        MathButton.operator('-'),
      ],
      [
        MathButton.number('1'),
        MathButton.number('2'),
        MathButton.number('3'),
        MathButton.operator('+'),
      ],
      [
        MathButton.number('0', showAsRoundedRectangle: true),
        MathButton.number('.'),
        MathButton.operator(
          '=',
          onPressed: () => Provider.of<CalculatorNotifier>(
            context,
            listen: false,
          ).getResult(),
        ),
      ],
    ];

    return Column(
      children: buttonRows.map((row) {
        return Expanded(
          child: Row(
            children: row,
          ),
        );
      }).toList(),
    );
  }
}
