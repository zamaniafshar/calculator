import 'package:calculator/logic/calculator_notifier.dart';
import 'package:calculator/view/calculator_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CalculatorNotifier(),
      child: const MaterialApp(
        home: CalculatorScreen(),
      ),
    );
  }
}
