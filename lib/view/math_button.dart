import 'package:calculator/logic/calculator_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MathButton extends StatelessWidget {
  const MathButton({
    super.key,
    required this.symbol,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.onPressed,
    required this.showAsRoundedRectangle,
  });

  const MathButton.number(
    this.symbol, {
    this.showAsRoundedRectangle = false,
  }) : backgroundColor = Colors.white,
       foregroundColor = Colors.black,
       onPressed = null;

  const MathButton.operator(
    this.symbol, {
    this.onPressed,
  }) : backgroundColor = Colors.orange,
       foregroundColor = Colors.black,
       showAsRoundedRectangle = false;

  const MathButton.function(
    this.symbol, {
    this.onPressed,
    this.showAsRoundedRectangle = false,
  }) : backgroundColor = Colors.white54,
       foregroundColor = Colors.black;

  final String symbol;
  final Color backgroundColor;
  final Color foregroundColor;
  final void Function()? onPressed;
  final bool showAsRoundedRectangle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: showAsRoundedRectangle ? 2 : 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: showAsRoundedRectangle
                ? RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(45),
                  )
                : const CircleBorder(),
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            elevation: 2,
            padding: EdgeInsets.zero,
          ),
          onPressed:
              onPressed ??
              () {
                Provider.of<CalculatorNotifier>(
                  context,
                  listen: false,
                ).input(symbol);
              },
          child: Center(
            child: Text(
              symbol,
              style: TextStyle(
                fontSize: 30,
                color: foregroundColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
