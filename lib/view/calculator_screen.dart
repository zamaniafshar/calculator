import 'package:calculator/calculator/expressions.dart';
import 'package:calculator/calculator/functions.dart';
import 'package:calculator/calculator/operators.dart';
import 'package:calculator/calculator/strategies.dart';
import 'package:calculator/logic/calculator_notifier.dart';
import 'package:calculator/view/calculator_buttons.dart';
import 'package:calculator/view/math_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      body: Column(
        children: [
          Expanded(
            child: Consumer<CalculatorNotifier>(
              builder: (context, notifier, child) {
                final state = notifier.value;

                return Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          _formatNumber(state.expression),
                          style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _formatNumber(state.result?.toString() ?? ''),
                          style: TextStyle(fontSize: 30, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const Icon(Icons.backspace_outlined),
              onPressed: () => Provider.of<CalculatorNotifier>(
                context,
                listen: false,
              ).deleteLast(),
            ),
          ),
          Expanded(
            flex: 2,
            child: CalculatorButtons(),
          ),
        ],
      ),
    );
  }

  String _formatNumber(String number) {
    // Simple comma formatting for display
    return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
}
